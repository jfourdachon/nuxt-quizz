<template>
    <div>
        <div class="mt-4" v-if="keyWordsTable.length > 0">
            <p>
                Pour chaque bonne réponse, renseignez au moins une mauvaise
                réponse
            </p>
            <b-table striped hover :items="reponsesTab" :fields="fields">
                <template v-slot:cell(text1)="row">
                    <b-form-input v-model="row.item.text1" />
                </template>
                <template v-slot:cell(text2)="row">
                    <b-form-input :state="false" v-model="row.item.text2" />
                </template>
            </b-table>
            {{ keyWordsTable }}
        </div>
        <p v-else>Aucun mot clé pour le moment</p>
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
        }
    },
    watch: {
        reponsesTab(newValue) {
            this.$emit('changeKeyWordsTable', newValue)
        },
    },
    mounted() {
        this.reponsesTab = this.keyWordsTable
    },
}
</script>