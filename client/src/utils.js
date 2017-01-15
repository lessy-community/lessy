import moment from 'moment'

function mapElementsById (elements, fk = 'id') {
  let byIds = {}
  elements.forEach((element) => {
    const id = element[fk]
    byIds[id] = element
  })
  return byIds
}

function formatDate (timestamp) {
  return moment.unix(timestamp).format('DD MMMM YYYY')
}

export {
  mapElementsById,
  formatDate,
}
