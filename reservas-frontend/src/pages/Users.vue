<template>
  <q-page class="column q-pa-xl">
    <div class="row">
      <div class="col-10"></div>
      <div class="col-2">
        <q-btn class="full-width" color="purple" label="Adicionar Usuário" @click="openModal(id = 0)"></q-btn>
      </div>
    </div>
    <div class="row">
      <q-table class="col-12" :columns="columns" :rows="rows">
        <template v-slot:body-cell-action="props">
          <q-td style="width: 150px;" :props="props">
              <q-btn flat round icon="edit" size="5" @click="openModal(props.row.id, props.row)"></q-btn>
              <q-btn flat round icon="delete" size="5" @click="deleteUser(props.row.id)"></q-btn>
        </q-td>
      </template>
      
      </q-table>

    </div>

    <q-dialog v-if="modal" v-model="modal" :key="modalKey">
      <q-card>
        <q-card-section>
          <q-form class="fit column flex-center q-col-gutter-sm q-py-md q-py-sm" @submit="userIdEdit ? editUser(userIdEdit) : createUser()">
              <q-input v-model="user.name" style="width: 300px" standout="bg-purple text-white" label="Nome"></q-input>
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
                <q-btn class="full-width" color="purple" type="submit">{{ userIdEdit ? 'Alterar' : 'Adicionar'}}</q-btn>
              </div>

          </q-form>
        </q-card-section>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useQuasar } from 'quasar'
import axios from 'axios'
const $q = useQuasar()

const rows = ref([{}])
const columns = ref([
  { name: 'name', align: 'center', label: 'Nome', field: 'name', sortable: true },
  { name: 'email', align: 'center', label: 'Email', field: 'email', sortable: true },
  { name: 'action', align: 'center', field: 'action' },
])

const modal = ref(false)
const isPwd = ref(true)
const user = reactive({
  name: '',
  email: '',
  password: null
})

const modalKey = ref(0)

const userIdEdit = ref(null)

const setup = async () => {
  try {
    const { data } = await getUsers()
    rows.value = data
  } catch(e) {
    console.log(e)
  }
}

const createUser = async () => {
  console.log('create')
  try {
    await axios.post('http://localhost:3030/users', {
      ...user
    })

    modal.value = false

    await setup()
  } catch (e) {
    console.log(e)
  }
}

const getUsers = async () => {
  const { data } = await axios.get('http://localhost:3030/users', {
    headers: {
      Authorization: `Bearer ${$q.localStorage.getItem('accessToken')}`
    } 
  })

  return data
}

const editUser = async (id) => {
  try {
    await axios.patch(`http://localhost:3030/users/${id}`,
      { ...user.password ? { name: user.name, email: user.email, password: user.password } :
      { name: user.name, email: user.email }
    },{
      headers: {
        Authorization: `Bearer ${$q.localStorage.getItem('accessToken')}`
      } 
    })

    modal.value = false
  
    await setup();
  } catch (e) {
    console.log(e)
  }
}

const deleteUser = async (id) => {
  try {
    await axios.delete(`http://localhost:3030/users/${id}`, {
      headers: {
        Authorization: `Bearer ${$q.localStorage.getItem('accessToken')}`
      } 
    })
  
    await setup();
  } catch (e) {
    console.log(e)
  }
}

const cleanUser = () => {
  user.name = ''
  user.email = ''
  user.password = null
}

const openModal = (id, userRow) => {
  cleanUser()
  if (userRow) {
    user.name = userRow.name
    user.email = userRow.email
  }

  userIdEdit.value = id
  modalKey.value++
  modal.value = true
}

onMounted(async () => {
  await setup()
})


</script>
