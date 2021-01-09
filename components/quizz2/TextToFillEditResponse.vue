<template>
    <div>
        <div class="mt-4" v-if="keyWordsTable.length > 0">
            <p>
                Pour chaque bonne réponse, renseignez au moins une mauvaise
                réponse
            </p>
            <b-table hover :items="reponsesTab" :fields="fields">
                <template v-slot:cell(text1)="row">
                    <b-form-input
                        v-model="row.item.text1"
                    />
                </template>
                <template v-slot:cell(text2)="row">
                    <b-form-input v-model="row.item.text2" />
                </template>
            </b-table>
        </div>
        <p v-else>Aucun mot clé pour le moment</p>
        <p v-if="error" style="color: red">
            Veuillez mettre au moins une mauvaise réponse par ligne
        </p>
        <b-button
            variant="outline-success"
            class="mt-3"
            @click="valideResponseHandler"
            >Valider</b-button
        >
    </div>
</template>
<script>
export default {
    name: 'TextToFillEditResponse',
    props: {
        keyWordsTable: { type: Array, required: true },
    },
    data() {
        return {
            fields: [
                { text: 'Bonne Réponse' },
                { text1: 'Mauvaise Réponse 1' },
                { text2: 'Mauvaise Réponse 2' },
            ],
            reponsesTab: [],
            loading: true,
            error: false,
        }
    },
    watch: {
        reponsesTab(newValue) {
            this.$emit('changeKeyWordsTable', newValue)
        },
    },
    methods: {
        valideResponseHandler() {
            this.reponsesTab.forEach((elem, index) => {
                if (!elem.text1 && !elem.text2) {
                    this.error = true
                } else {
                    this.error = false
                    this.$emit('validStep3')
                }
            })
        },
    },
    mounted() {
        this.reponsesTab = this.keyWordsTable
    },
}
</script>