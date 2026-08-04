(() => {
  const root = document.documentElement;
  const toggle = document.querySelector("[data-theme-toggle]");
  const savedTheme = window.localStorage.getItem("theme");
  const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
  const initialTheme = savedTheme || (prefersDark ? "dark" : "light");

  root.dataset.theme = initialTheme;

  if (!toggle) return;

  const updateToggle = () => {
    const isDark = root.dataset.theme === "dark";
    toggle.textContent = isDark ? "☀" : "☾";
    toggle.setAttribute("aria-label", isDark ? "Use light theme" : "Use dark theme");
    toggle.setAttribute("aria-pressed", String(isDark));
  };

  toggle.addEventListener("click", () => {
    const nextTheme = root.dataset.theme === "dark" ? "light" : "dark";
    root.dataset.theme = nextTheme;
    window.localStorage.setItem("theme", nextTheme);
    updateToggle();
  });

  updateToggle();
})();
