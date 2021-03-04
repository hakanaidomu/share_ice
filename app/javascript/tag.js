if (location.pathname.match("posts/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("TagInput_tag");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("TagInput_tag").value;
      console.log(keyword);
    });
  });
};