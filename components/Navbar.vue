<template>
  <b-container fluid class="main-nav">
    <b-row align-h="between" align-v="center" class="navbar m-0 p-0">
      <b-col  class="text-center py-3 border-right" v-bind:class="{ 'menu-open-border': $route.path === '/'}">
        <nuxt-link to="/">
          <h5 class="pt-3 pb-3">Meli Mélo</h5>
        </nuxt-link>
      </b-col>
      <b-col  class="text-center py-3 border-right" v-bind:class="{ 'menu-open-border': $route.path === '/quizz-2'}">
        <nuxt-link to="/quizz-2">
          <h5 class="pt-3 pb-3">Texte à trou</h5>
        </nuxt-link>
      </b-col>
      <b-col  class="text-center py-3 border-right">
        <nuxt-link to="/draglist">
          <h5 class="pt-3 pb-3">Drag list</h5>
        </nuxt-link>
      </b-col>

      <b-col  class="text-center py-3 border-right">
        <nuxt-link to="/Quizz4">
          <h5 class="pt-3 pb-3">Drag text</h5>
        </nuxt-link>
      </b-col>
      <b-col  class="text-center py-3">
        <nuxt-link to="/Quizz5">
          <h5 class="pt-3 pb-3">Drag Category</h5>
        </nuxt-link>
      </b-col>
      <p></p>
    </b-row>
  </b-container>
</template>

<style scoped src="~/assets/css/navbar.css"></style>

<script>
export default {
    name: NavBar
}
</script>
