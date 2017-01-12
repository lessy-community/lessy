function mapElementsById (elements, fk = 'id') {
  let byIds = {}
  elements.forEach((element) => {
    const id = element[fk]
    byIds[id] = element
  })
  return byIds
}

export {
  mapElementsById,
}
