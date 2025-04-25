document.addEventListener("DOMContentLoaded", () => {
  const setupImagePreview = (inputId, previewId) => {
    const input = document.getElementById(inputId);
    const preview = document.getElementById(previewId);

    if (input && preview) {
      input.addEventListener("change", (e) => {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = () => {
            preview.src = reader.result;
            preview.classList.remove("d-none"); // 必要であれば表示
          };
          reader.readAsDataURL(file);
        }
      });
    }
  };

  // ユーザー画像用
  setupImagePreview("user_image_input", "preview");

  // 投稿画像用
  setupImagePreview("post_image_input", "preview_image");
});