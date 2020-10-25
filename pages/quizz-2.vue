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
    <b-tabs content-class="mt-3">
      <b-tab title="Édition" active>
        <h5>Entrez le(s) résultat final dans le formulaire ci dessous</h5>
        <label for="editor"
          >Note: Placez les mots clés(qui seront dans les trous) entre crochets,
          ex: les règles de [sécurité]</label
        >
        <client-only>
          <vue-editor
            v-model="text"
            :editorOptions="customToolbar"
          ></vue-editor>
        </client-only>
        <b-button variant="outline-success" class="mt-3" @click="handleKeyWords"
          >Suivant</b-button
        >
        <div class="mt-4" v-if="keyWordsTable.length > 0">
          <p>Pour chaque bonne réponse, renseignez 2 mauvaises réponses</p>
          <b-table striped hover :items="keyWordsTable" :fields="fields">
            <template v-slot:cell(badAnswer1)="row">
              <b-form-input v-model="row.item.badAnswer1" />
            </template>
            <template v-slot:cell(badAnswer2)="row">
              <b-form-input v-model="row.item.badAnswer2" />
            </template>
          </b-table>
        </div>
      </b-tab>
      <b-tab title="Résultat" @click="handleResult">
        <b-col v-for="(item, key) in resultTable" :key="key">
          <b-form-select
            :options="item"
            class="exemple-select ml-2"
          ></b-form-select>
        </b-col>
      </b-tab>
    </b-tabs>
  </div>
</template>

<script>
import { collectCoverage } from "~/jest.config";
export default {
  data() {
    return {
      text: "",
      result: [],
      keyWordsTable: [],
      resultTable: [],
      fields: [
        { goodAnswer: "Bonne Réponse" },
        { badAnswer1: "Mauvaise Réponse 1" },
        { badAnswer2: "Mauvaise Réponse 2" }
      ],
      exemple1: [
        { value: "", text: "pouvez" },
        { value: "", text: "pourrez" }
      ],
      exemple2: [
        { value: "", text: "quizz" },
        { value: "", text: "module" },
        { value: "", text: "exercice" }
      ],
      customToolbar: {
        modules: {
          toolbar: false
        }
      }
    };
  },
  watch: {
    text: function(newVal, val) {
      // Span does not work in watch

      // this.keyWordsTable = [];
      // const match = newVal.match(/\[.*?\]/g);
      // match?.map(el => {
      //   newVal.replace(
      //     el,
      //     `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
      //   );
      //   this.keyWordsTable.push({
      //     goodAnswer: el.slice(1, -1),
      //     badAnswer1: "",
      //     badAnswer2: ""
      //   });
      // });
    }
  },
  methods: {
    handleKeyWords() {
      this.keyWordsTable = [];
      const match = this.text.match(/\[.*?\]/g);
      match?.map(el => {
        this.text = this.text.replace(
          el,
          `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
        );
        this.keyWordsTable.push({
          goodAnswer: el.slice(1, -1),
          badAnswer1: "",
          badAnswer2: ""
        });
      });
    },
    handleResult() {
      this.resultTable = [];
      this.keyWordsTable?.map((elem, index) => {
        this.resultTable.push([
          { text: elem.goodAnswer },
          { text: elem.badAnswer1 },
          { text: elem.badAnswer2 }
        ]);
      });
      
      // Faire un objet du style {select: resultTable, text: "le text avant le select" }

      this.result = this.text.replace(/<[^>]*>?/gm, "");
      const match = this.text.match(/\[.*?\]/g);
      // v-html sies not work with bootstrap element
      // match?.map((el, key) => {
      //   this.result = this.result.replace(
      //     el,
      //     '<b-form-select :options="' +
      //       this.resultTable[key] +
      //       '" class="exemple-select mx-2"></b-form-select>'
      //   );
      // });
    }
  },
  mounted() {}
};
</script>

<style scoped src="~/assets/css/quizz-2.css"></style>
