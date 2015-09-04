class ImplicitInfoView extends HTMLElement

ImplicitInfoView.createdCallback = () ->
  this.innerHTML = "<b>Inner Html</b>"



module.exports = ImplicitInfoView = document.registerElement('implicit-info', {prototype: ImplicitInfoView.prototype})
