<template>
  <div class="container mt-4">
    <h3>Text a trous</h3>
    <b-row class="pl-3 mb-4" align-v="center">
      Exemple: Voici ce que vous
      <b-form-select
        v-model="selected"
        :options="options1"
        class="exemple-select mx-2"
      ></b-form-select>
      réaliser avec ce
      <b-form-select
        v-model="selected"
        :options="options2"
        class="exemple-select ml-2"
      ></b-form-select>
    </b-row>
    <h5>Entrez le résultat final dans le formulaire ci dessous</h5>
    <label for="textarea"
      >Note: Placez les mots clés(qui seront dans les trous) entre crochets, ex:
      les règles de [sécurité]</label
    >
    <b-form-textarea
      id="textarea"
      v-model="text"
      placeholder="Votre texte ici..."
      rows="15"
      max-rows="15"
    ></b-form-textarea>
    <b-button variant="outline-success" class="mt-3" @click="handleKeyWords"
      >Suivant</b-button
    >
    <div class="mt-4">
      <p>Pour chaque mot clé, renseignez 2 mauvaises réponses</p>
      <b-table striped hover :items="keyWordsTable" :fields="fields">
        <template v-slot:cell(Mauvaise_reponse_1)="row">
          <b-form-input v-model="row.item.Mauvaise_reponse_1" />
        </template>
        <template v-slot:cell(Mauvaise_reponse_2)="row">
          <b-form-input v-model="row.item.Mauvaise_reponse_2" />
        </template>
      </b-table>
      <b-button
        variant="outline-success"
        class="mt-3"
        @click="handleEditAnswers"
        >Suivant</b-button
      >
    </div>
    <p></p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      text: "",
      keyWordsTable: [],
      step2: false,
      fields: [
        {
          Bonne_Réponse: " Bonne_Réponse",
          Mauvaise_reponse_1: " Mauvaise_reponse_1",
          Mauvaise_reponse_2: " Mauvaise_reponse_2"
        }
      ],
      options1: [
        { value: "", text: "pouvez" },
        { value: "", text: "pourrez" }
      ],
      options2: [
        { value: "", text: "quizz" },
        { value: "", text: "module" },
        { value: "", text: "exercice" }
      ]
    };
  },
  methods: {
    handleKeyWords(e) {
      e.preventDefault();
      const regex = /\[.*?\]/g;
      const match = this.text.match(regex);
      const keyWords = match.map(el => {
        this.keyWordsTable.push({
          Bonne_réponse: el.slice(1, -1),
          Mauvaise_reponse_1: "",
          Mauvaise_reponse_2: ""
        });
      });
    },
    handleEditAnswers(e) {
      e.preventDefault();
      console.log(this.keyWordsTable);
    }
  }
};
</script>

<style scoped src="~/assets/css/quizz-2.css"></style>
