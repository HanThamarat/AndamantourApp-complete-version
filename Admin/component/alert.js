const button = document.getElementsByName("login"),
      toast = document.querySelector(".toast")
      closeIcon = document.querySelector(".close"),
      progrees = document.querySelector(".progrees");


     button.addEventListener("click", () => {
        toast.classList.add("active");
        progrees.classList.add("active");

        setTimeout(() => {
            toast.classList.remove("active");
        }, 5000);

        setTimeout(() => {
            progrees.classList.remove("active");
        }, 5300);
     });

     closeIcon.addEventListener("click", () => {
        toast.classList.remove("active");

        setTimeout(() => {
            progrees.classList.remove("active");
        }, 300);
     });