function objectsToOptions (objects, valueKey, labelKey) {
  return objects.map(obj => {
    return {
      value: obj[valueKey],
      label: obj[labelKey],
    }
  })
}

export {
  objectsToOptions,
}
