<template>
    <div>
        <div v-for="input in inputCount" :key="input">
            <b-row align-v="center">
                <b-col sm="8">
                    <b-form-input class="my-3"></b-form-input>
                </b-col>
                <b-col sm="4">
                    <b-icon class="h2" icon="x-circle" @click="addInput"></b-icon>
                </b-col>
            </b-row>
        </div>
        <div>
            <b-icon class="h1" icon="plus-circle" @click="addInput"></b-icon>
            <div class="mt-2">Value: {{ text }}</div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            text: '',
            inputCount: 3,
        }
    },
    methods: {
        addInput() {
            this.inputCount += 1
        },
    },
}
</script>
