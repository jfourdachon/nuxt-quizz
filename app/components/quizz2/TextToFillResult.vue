<template>
    <div align-v="center">
        <span v-for="(item, key) in contentTab" :key="key" >
            <span v-if="item.type === 'text'" >{{item.content}}</span>
            <span v-else class="span">
                <b-form-select :options="item.content" class="mx-1"></b-form-select>
            </span>
        </span>
        <pre>{{contentTab}}</pre>
    </div>
</template>

<script>
export default {
    name: 'TextToFillResult',
    props: {
        result: { type: Array, required: true },
    },
      data() {
        return {
            contentTab: [],
        };
    },
    watch: {
        result(newValue) {
            this.contentTab = newValue;
        }
    },
}
</script>
<style scoped>
/* unset bootstrap select default size */
.custom-select {
    width: unset;
}
</style>