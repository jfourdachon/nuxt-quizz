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
            @text-change="textChanged"
            v-model="text"
            :editorOptions="customToolbar"
            @focus="onEnter"
            @blur="onLeave"
          ></vue-editor>
        </client-only>
        {{text}}
        <b-button variant="outline-success" class="mt-3" @click="handleKeyWords"
          >Suivant</b-button
        >
        <div class="mt-4" v-if="keyWordsTable.length > 0">
          <p>Pour chaque bonne réponse, renseignez 2 mauvaises réponses</p>
          <b-table striped hover :items="keyWordsTable" :fields="fields">
            <template v-slot:cell(text1)="row">
              <b-form-input v-model="row.item.text1" />
            </template>
            <template v-slot:cell(text2)="row">
              <b-form-input v-model="row.item.text2" />
            </template>
          </b-table>
        </div>
      </b-tab>
      <b-tab title="Résultat" @click="handleResult">
        <div v-html="result" />
      </b-tab>
    </b-tabs>
  </div>
</template>

<script>
export default {
  data() {
    return {
      text: "",
      result: [],
      keyWordsTable: [],
      fields: [
        { text: "Bonne Réponse" },
        { text1: "Mauvaise Réponse 1" },
        { text2: "Mauvaise Réponse 2" },
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
      isEditing: false,
    };
  },
  computed: {
    // fullText() {
    //   this.isEditing = true;
    //   this.keyWordsTable = [];
    //   let newVal = this.text;
    //   const match = newVal.match(/\[.*?\]/g);
    //   match?.map((el) => {
    //     newVal = newVal.replace(
    //       el,
    //       `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
    //     );
    //     this.keyWordsTable.push({
    //       goodAnswer: el.slice(1, -1),
    //       badAnswer1: "",
    //       badAnswer2: "",
    //     });
    //   });
    //   console.log({ newVal });
    //   this.text = null;
    //   this.text = newVal;
    //   this.isEditing = false;
    //   return this.text;
    // },
  },
  watch: {
    text(newVal, val) {
      // Span does not work in watch
      // this.keyWordsTable = [];
      // const match = newVal.match(/\[.*?\]/g);
      // match?.map(el => {
      //   newVal = newVal.replace(
      //     el,
      //     `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
      //   );
      //   this.keyWordsTable.push({
      //     goodAnswer: el.slice(1, -1),
      //     badAnswer1: "",
      //     badAnswer2: ""
      //   });
      // });
      // console.log({newVal});
      // return newVal;
    },
  },
  methods: {
    handleKeyWords() {
      this.keyWordsTable = [];
      const match = this.text.match(/\[.*?\]/g);
      match?.map((el) => {
        this.text = this.text.replace(
          el,
          `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
        );
        this.keyWordsTable.push({
          text: el.slice(1, -1),
          text1: "",
          text2: "",
        });
      });
    },
    handleResult() {
      // faire un tableau d'obj de chaque elem de la liste de type [{type: text, content: "exemple", type: select, content: tableau de reponse}]
      // dans un v-for de ce tableau faire un v-if type === text afficher du text, else select bootstrap
      const tab = [];
      let options = [];
      this.keyWordsTable?.map((elem, index) => {
        tab.splice(0, tab.length);
        tab.push(elem.text, elem.text1, elem.text2);
        this.shuffleArray(tab);
        tab.map((elem, key) => {
          !options[index]
            ? (options[
                index
              ] = `<option value="value${key}">${tab[key]}</option>`)
            : (options[
                index
              ] += `<option value="value${key}">${tab[key]}</option>`);
        });
      });
      this.result = this.text.replace(/<[^>]*>?/gm, "");
      const match = this.text.match(/\[.*?\]/g);
      match?.map((el, key) => {
        this.result = this.result.replace(
          el,
          `<select name="name" class="exemple-select ml-2">
            <option disabled selected value></option>
            ${options[key]}
          </select>`
        );
      });
    },
    shuffleArray(array) {
      for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
      }
      return array;
    },
    textChanged(delta, oldDelta, source) {
      // const match = this.text.match(/\[.*?\]/g);
      // match?.map((el) => {
      //   this.text = this.text.replace(
      //     el,
      //     `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
      //   );
      //   this.keyWordsTable.push({
      //     goodAnswer: el.slice(1, -1),
      //     badAnswer1: "",
      //     badAnswer2: "",
      //   });
      // });
    },
    onEnter(quill) {
      console.log({quill});
    },
     onLeave(quill) {
      console.log({quill});
    }
  },
  mounted() {}
};
</script>

<style scoped src="~/assets/css/quizz-2.css"></style>
