const examCollapse = new DocumentFragment();
const url = "http://localhost:4001/exams";

const exams = document.querySelector(".exams");

fetch(url)
  .then((response) => response.json())
  .then((data) => {
    data.forEach(function (test) {
      const examDiv = document.createElement("div");
      examDiv.classList.add("collapsible");

      const examDivCover = document.createElement("div");
      examDivCover.classList.add("collapsible-cover");

      const collHeader = document.createElement("p");
      collHeader.classList.add('exam-title');
      collHeader.textContent = `Token: ${test["token resultado exame"]} | Paciente: ${test["nome paciente"]} | Data: ${test["data exame"]}`;
      examDivCover.appendChild(collHeader);
      examDiv.appendChild(examDivCover);

      const examDataDiv = document.createElement('div');
      examDataDiv.classList.add('exam-data');
      examDiv.appendChild(examDataDiv);

      makePatientTable();

      function makePatientTable() {
        const patientDataTitle = document.createElement('h3');
        patientDataTitle.textContent = 'Dados do paciente:';
        patientDataTitle.classList.add('patient-data-title');
        examDataDiv.appendChild(patientDataTitle);

        const patientInfo = document.createElement("table");
        const patientInfoHeader = document.createElement("tr");
        patientInfo.appendChild(patientInfoHeader);
        const patientInfoBody = document.createElement("tr");
        patientInfo.appendChild(patientInfoBody);
        examDiv.appendChild(patientInfo);
        examDataDiv.appendChild(patientInfo);

        const patientDataRaw = {
          Nome: test["nome paciente"],
          Cpf: test["cpf"],
          Email: test["email paciente"],
          Nascimento: test["data nascimento paciente"],
          Endereço: test["endereço/rua paciente"],
          Cidade: test["cidade paciente"],
          Estado: test["estado paciente"],
        };

        const patientAttributeTitles = Object.keys(patientDataRaw);

        patientAttributeTitles.forEach(attribute => {
          const patientTh = document.createElement('th');
          patientTh.textContent = attribute;
          patientInfoHeader.appendChild(patientTh);
        });

        const patientAttributes = Object.values(patientDataRaw);

        patientAttributes.forEach(attribute => {
          const patientTd = document.createElement('td');
          patientTd.textContent = attribute;
          patientInfoBody.appendChild(patientTd);
        });
      }

      makeDoctorTable();

      function makeDoctorTable() {
        const doctorDataTitle = document.createElement('h3');
        doctorDataTitle.textContent = 'Médico responsável:';
        doctorDataTitle.classList.add('doctor-data-title');
        examDataDiv.appendChild(doctorDataTitle);

        const doctorInfo = document.createElement("table");
        const doctorInfoHeader = document.createElement("tr");
        doctorInfo.appendChild(doctorInfoHeader);
        const doctorInfoBody = document.createElement("tr");
        doctorInfo.appendChild(doctorInfoBody);
        examDiv.appendChild(doctorInfo);
        examDataDiv.appendChild(doctorInfo);

        const doctorDataRaw = {
          Nome: test['médico responsável']["nome médico"],
          Crm: test['médico responsável']["crm médico"],
          'Crm estado': test['médico responsável']["crm médico estado"],
          Email: test['médico responsável']["email médico"],
        };

        const doctorAttributeTitles = Object.keys(doctorDataRaw);

        doctorAttributeTitles.forEach(attribute => {
          const doctorTh = document.createElement('th');
          doctorTh.textContent = attribute;
          doctorInfoHeader.appendChild(doctorTh);
        });

        const doctorAttributes = Object.values(doctorDataRaw);

        doctorAttributes.forEach(attribute => {
          const doctorTd = document.createElement('td');
          doctorTd.textContent = attribute;
          doctorInfoBody.appendChild(doctorTd);
        });
      }

      makeExamResultsTable();

      function makeExamResultsTable() {
        const resultsDataTitle = document.createElement('h3');
        resultsDataTitle.textContent = 'Resultados do exame:';
        resultsDataTitle.classList.add('results-data-title');
        examDataDiv.appendChild(resultsDataTitle);

        const examResultsInfo = document.createElement("table");
        const examResultsInfoHeader = document.createElement("tr");
        examResultsInfo.appendChild(examResultsInfoHeader);
        examDiv.appendChild(examResultsInfo);
        examDataDiv.appendChild(examResultsInfo);

        const examResultsTitles = ['Categoria de exame', 'Limites', 'Resultado'];

        examResultsTitles.forEach(attribute => {
          const examResultTh = document.createElement('th');
          examResultTh.textContent = attribute;
          examResultsInfoHeader.appendChild(examResultTh);
        });

        const examResultsDataRaw = test['testes deste exame'];

        examResultsDataRaw.forEach(resultAttribute => {
          const examResultsTr = document.createElement('tr');
          examResultsInfo.appendChild(examResultsTr);
          Object.values(resultAttribute).forEach(attribute => {
            const examResultsTd = document.createElement('td');
            examResultsTd.textContent = attribute;
            examResultsTr.appendChild(examResultsTd);
          })
        })
      }
      examCollapse.appendChild(examDiv);


      function toggleInfo() {
        if (examDataDiv.style.maxHeight){
          examDataDiv.style.maxHeight = null;
        } else {
          examDataDiv.style.maxHeight = examDataDiv.scrollHeight + "px";
        }

        collHeader.classList.toggle("active");
      }

      examDivCover.addEventListener('click', toggleInfo);

    });
  })
  .then(() => {
    exams.appendChild(examCollapse);
  })
  .catch(function (error) {
    console.log(error);
  });


