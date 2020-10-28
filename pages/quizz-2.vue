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
      <b-tab title="Texte" active>
        <h5>Entrez le texte final dans le formulaire ci dessous</h5>
        <label for="editor"
          >Note: Placez les mots clés(qui seront dans les trous) entre crochets,
          ex: les règles de [sécurité]</label
        >
        <client-only>
          <vue-editor
            v-model="text"
            :editorOptions="customToolbar"
            @focus="onEnter"
            @blur="onLeave"
          ></vue-editor>
        </client-only>
        <b-button variant="outline-success" class="mt-3" @click="handleKeyWords"
          >Suivant</b-button
        >
        {{keyWordsTable}}
      </b-tab>
       <b-tab title="Édition" @click="handleKeyWords">
        <TextToFillEditResponse @changeKeyWordsTable="updateKeyWordsTable" :keyWordsTable="keyWordsTable"></TextToFillEditResponse>
      </b-tab>
      <b-tab title="Résultat" @click="handleResult">
        <TextToFillResult :result="result"></TextToFillResult>
      </b-tab>
    </b-tabs>
  </div>
</template>

<script>
export default {
  data() {
    return {
      text: '',
      resultTable: [],
      result: [],
      keyWordsTable: [],
      fields: [
        { text: 'Bonne Réponse' },
        { text1: 'Mauvaise Réponse 1' },
        { text2: 'Mauvaise Réponse 2' },
      ],
      exemple1: [
        { value: '', text: 'pouvez' },
        { value: '', text: 'pourrez' },
      ],
      exemple2: [
        { value: '', text: 'quizz' },
        { value: '', text: 'module' },
        { value: '', text: 'exercice' },
      ],
      customToolbar: {
        modules: {
          toolbar: false,
        },
      },
      isEditing: false,
    };
  },
  mounted(){
     // add span in editor
      const match = this.text.match(/\[.*?\]/g);
      match?.map(
        (el) =>
          (this.text = this.text.replace(
            el,
            `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
          )
        )
      );
  },
  methods: {
    handleKeyWords() {
      const match = this.text.match(/\[.*?\]/g);
      match?.map((el, index) => {
        this.text = this.text.replace(
          el,
          `<span style="background-color: rgb(255, 194, 102);">${el}</span>`
        );
        if (!this.keyWordsTable[index]) this.keyWordsTable.push({text: el.slice(1, -1)})
        else if (this.keyWordsTable[index].text === el.slice(1, -1)) this.keyWordsTable[index] = this.keyWordsTable[index]
        else this.keyWordsTable.splice(index, 1, { text: el.slice(1, -1)  } );
      });
    },
    handleResult() {
      this.resultTable = [];
      this.result = [];
      console.log(this.keyWordsTable);
      this.keyWordsTable?.map((elem, index) => {
        this.resultTable.push([
          { text: elem.text, goodResponse: true },
          { text: elem.text1, goodResponse: false },
          { text: elem.text2, goodResponse: false }
        ]);
         this.shuffleArray(this.resultTable[index]);
      })
      // Remove html tags from editor
      this.text = this.text.replace(/<[^>]*>?/gm, "");
      this.text = this.text.replace('&nbsp;', "");
      // put editor content in object with both text and select options
      const splittedText = this.text.split(/\[.*?\]/g);
      splittedText.map((elem, key) => {
        elem && this.result.push({ type: 'text', content: elem });
        this.keyWordsTable[key] &&
          this.result.push({ type: 'array', content: this.resultTable[key] });
      });

    },
    shuffleArray(array) {
      // shuffle options in select
      for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
      }
      return array;
    },
    onEnter(quill) {
      // remove all span in editor on Focus
      const match = this.text.match(/<\/?span[^>]*>/g, '');
      match?.map((el) => {
        this.text = this.text.replace(el, '');
      });
      quill.root.innerHTML = this.text;
    },
    onLeave(quill) {
      // add span in editor on Blur
      const match = this.text.match(/\[.*?\]/g);
      match?.map(el => this.text = this.text.replace(el,`<span style="background-color: rgb(255, 194, 102);">${el}</span>`));
    },
    updateKeyWordsTable(newValue) {
      console.log({newValue});
      this.keyWordsTable = newValue;
    }
  },
};
</script>

<style scoped src="~/assets/css/quizz-2.css"></style>
