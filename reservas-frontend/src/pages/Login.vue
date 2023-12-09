<template>
  <q-form class="fit column flex-center q-col-gutter-md" @submit="login">
    <h6 style="margin-top: 100px; margin-bottom: 0">Login</h6>
    <q-input v-model="user.email" style="width: 300px" standout="bg-purple text-white" label="Email">
    </q-input>

    <q-input v-model="user.password" style="width: 300px" :type="isPwd ? 'password' : 'text'" standout="bg-purple text-white" label="Senha">
      <template v-slot:append>
          <q-icon
            :name="isPwd ? 'visibility_off' : 'visibility'"
            class="cursor-pointer"
            @click="isPwd = !isPwd"
          />
        </template>
    </q-input>

    <div style="width: 300px">

      <q-btn class="full-width" color="purple" type="submit">button</q-btn>
    </div>

  </q-form>
</template>

<script setup>
import { ref, reactive } from 'vue'
import axios from 'axios'
import { LocalStorage, useQuasar } from 'quasar'
import { useRouter } from 'vue-router'

const $q = useQuasar()

const router = useRouter()

const isPwd = ref(true)
const user = reactive({
  email: '',
  password: ''
})

const login = async () => {
  try {
    const data = await getToken()
    saveUserData(data)
    changePage()
  } catch (e) {
    $q.notify({
      message: 'Erro ao fazer login',
      color: 'red',
      position: 'top-right'
    })
  }
}

const getToken = async () => {
  const { data } = await axios.post('http://localhost:3030/authentication', {
    "strategy": "local",
    ...user
  })

  return data
}

const saveUserData = (obj = {}) => {
  $q.localStorage.set("user", obj.user)
  $q.localStorage.set("accessToken", obj.accessToken)
}

const changePage = () => {
  router.push("/users")
}
</script>
