import { humanize } from "@/lib/utils/textConverter";
import { useState, useEffect, useRef } from "react";
import * as Icon from "react-feather";

const HomepageTab = ({ homepage_tab }) => {
  const { title, description, tab_list } = homepage_tab;
  const [tab, setTab] = useState(0);
  const autoplayRef = useRef(null);
  const AUTOPLAY_MS = 8000;
  const mediaRef = useRef(null);
  const imgRefs = useRef([]);

  // autoplay: advance every AUTOPLAY_MS ms
  useEffect(() => {
    autoplayRef.current = setInterval(() => {
      setTab((t) => (t + 1) % tab_list.length);
    }, AUTOPLAY_MS);
    return () => clearInterval(autoplayRef.current);
  }, [tab_list.length]);

  // measure images and set media container height to tallest image to avoid overlap
  const measure = () => {
    if (!mediaRef.current || !imgRefs.current) return;
    let max = 0;
    imgRefs.current.forEach((img) => {
      if (!img) return;
      // Prefer measured clientHeight (rendered height). Fall back to aspect ratio calculation
      // for images that expose natural sizes. This helps with SVGs and responsive images.
      const clientH = img.clientHeight || 0;
      const aspectH = img.naturalHeight && img.naturalWidth ? (img.naturalHeight / img.naturalWidth) * img.clientWidth : 0;
      const h = clientH > 0 ? clientH : aspectH || img.offsetHeight || 0;
      if (h > max) max = h;
    });
    if (max > 0) {
      mediaRef.current.style.height = `${Math.ceil(max)}px`;
      mediaRef.current.classList.add("is-measured");
    } else {
      // remove any previous measured state so panels remain in-flow
      mediaRef.current.style.height = "";
      mediaRef.current.classList.remove("is-measured");
    }
  };

  useEffect(() => {
    // measure once images load
    measure();
    window.addEventListener("resize", measure);
    return () => window.removeEventListener("resize", measure);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleSetTab = (i) => {
    setTab(i);
    // reset autoplay timer
    if (autoplayRef.current) {
      clearInterval(autoplayRef.current);
      autoplayRef.current = setInterval(() => {
        setTab((t) => (t + 1) % tab_list.length);
      }, AUTOPLAY_MS);
    }
  };

  return (
    <div className="tab gx-5 row items-center">
      <div className="lg:col-7 lg:order-2">
        <div className="tab-content">
          <div className="tab-media" ref={mediaRef}>
            {tab_list.map((item, index) => (
              <div
                key={index}
                className={`tab-content-panel ${tab === index ? "active" : ""}`}
                aria-hidden={tab !== index}
              >
                <img
                  ref={(el) => (imgRefs.current[index] = el)}
                  className="w-full object-contain"
                  src={item.image}
                  alt={item.title}
                  onLoad={measure}
                />
              </div>
            ))}
          </div>
        </div>
      </div>
      <div className="mt-6 lg:col-5 lg:order-1 lg:mt-0">
        <div className="text-container">
          <h2 className="lg:text-4xl">{title}</h2>
          <p className="mt-4">{description}</p>
          <ul className="tab-nav mt-8! border-b-0">
            {tab_list.map((item, index) => {
              const FeatherIcon = Icon[humanize(item.icon)];
              return (
                <li
                  key={index}
                  className={`tab-nav-item ${tab === index ? "active" : ""}`}
                  onClick={() => handleSetTab(index)}
                >
                  <span className="tab-icon mr-3">
                    <FeatherIcon />
                  </span>
                  {item.title}
                </li>
              );
            })}
          </ul>
        </div>
      </div>
    </div>
  );
};

export default HomepageTab;
