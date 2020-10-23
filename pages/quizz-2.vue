<template>
  <div class="container mt-4">
    <h3>Text a trous</h3>
    <b-row class="pl-3 mb-4" align-v="center">
      Exemple: Voici ce que vous
      <b-form-select
        :options="exemple1"
        class="exemple-select mx-2"
      ></b-form-select>
      réaliser avec ce
      <b-form-select
        :options="exemple2"
        class="exemple-select ml-2"
      ></b-form-select>
    </b-row>
    <h5>Entrez le résultat final dans le formulaire ci dessous</h5>
    <label for="editor"
      >Note: Placez les mots clés(qui seront dans les trous) entre crochets, ex:
      les règles de [sécurité]</label
    >
    <b-form-textarea
      id="editor"
      v-model="text"
      placeholder="Votre texte ici..."
      rows="15"
      max-rows="15"
    ></b-form-textarea>
    <client-only>
      <vue-editor v-model="text" :editorOptions="customToolbar"></vue-editor>
    </client-only>
    <b-button variant="outline-success" class="mt-3" @click="handleKeyWords"
      >Suivant</b-button
    >
    <div class="mt-4" v-if="step2 === true">
      <p>Pour chaque mot clé, renseignez 2 mauvaises réponses</p>
      <b-table striped hover :items="keyWordsTable" :fields="fields">
        <template v-slot:cell(badAnswer1)="row">
          <b-form-input v-model="row.item.badAnswer1" />
        </template>
        <template v-slot:cell(badAnswer2)="row">
          <b-form-input v-model="row.item.badAnswer2" />
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
        { goodAnswer: "Bonne Réponse" },
        { badAnswer1: "Mauvaise Réponse 1" },
        { badAnswer2: "Mauvaise Réponse 2" },
      ],
      exemple1: [
        { value: "", text: "pouvez" },
        { value: "", text: "pourrez" },
      ],
      exemple2: [
        { value: "", text: "quizz" },
        { value: "", text: "module" },
        { value: "", text: "exercice" },
      ],
      customToolbar: {
        modules: {
          toolbar: false,
        },
      },
    };
  },
  methods: {
    putResulstInColor(txt, elem) {
      txt.replace(elem);
    },
    handleKeyWords() {
      const regex = /\[.*?\]/g;
      const match = this.text.match(this.regex);
      const keyWords = match.map((el) => {
        console.log({ el });
        this.keyWordsTable.push({
          goodAnswer: el.slice(1, -1),
          badAnswer1: "",
          badAnswer2: "",
        });
      });
      this.step2 = true;
      console.log(this.keyWordsTable);
    },
    handleEditAnswers(e) {
      e.preventDefault();
      console.log(this.keyWordsTable[0].goodAnswer);
    },
  },
  mounted() {},
};
</script>

<style scoped src="~/assets/css/quizz-2.css"></style>
