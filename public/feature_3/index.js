const examList = new DocumentFragment();
const url = "http://localhost:4008/api/exams";

const exams = document.querySelector(".exams");

fetch(url)
  .then((response) => response.json())
  .then((data) => {
    data.forEach(function (exam) {
      const examBtn = document.createElement("a");
      examBtn.classList.add("exam-link");
      examBtn.setAttribute("type", "button");
      examBtn.setAttribute("href", `http://localhost:4008/exams/${exam['token resultado exame']}`);
      examBtn.textContent = `Token: ${exam["token resultado exame"]} | Paciente: ${exam["nome paciente"]} | Data: ${exam["data exame"]}`;

      document.addEventListener("DOMContentLoaded", function(event) {
        alert('Hey')
      });

      examList.appendChild(examBtn);
    });
  })
  .then(() => {
    exams.appendChild(examList);
  })
  .catch(function (error) {
    console.log(error);
  });


