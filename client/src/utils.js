import moment from 'moment'

function mapElementsById (elements, fk = 'id') {
  let byIds = {}
  elements.forEach((element) => {
    const id = element[fk]
    byIds[id] = element
  })
  return byIds
}

function groupByFirstCharacter (array, attribute = null) {
  let groups = {}

  array.forEach(element => {
    const firstCharacter = attribute == null ? element[0] : element[attribute][0]
    const group = firstCharacter.match(/[a-z]/i) ? firstCharacter.toUpperCase() : '#'
    if (groups[group] == null) {
      groups[group] = []
    }
    groups[group].push(element)
  })

  return groups
}

function formatDate (timestamp) {
  return moment.unix(timestamp).format('DD MMMM YYYY')
}

export {
  mapElementsById,
  groupByFirstCharacter,
  formatDate,
}
