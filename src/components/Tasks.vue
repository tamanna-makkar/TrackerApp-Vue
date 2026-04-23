<template lang="">
  <div
    v-for="task in tasks"
    :key="task.id"
  >
    <Task
      :task="task"
      @toggle-reminder="$emit('toggle-reminder', task.id)"
      @delete-task="$emit('delete-task' ,task.id)"
    />
  </div>
</template>
<script>
import Task from "../components/Task.vue";
export default {
  name: "Tasks",
  components: {
    Task,
  },

  props: {
    tasks: Array,
  },
  emits: ["delete-task", "toggle-reminder"],
};
</script>
<style lang="">
</style>