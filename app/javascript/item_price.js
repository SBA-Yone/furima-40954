const price = () => {
  const priceInput = document.getElementById('item-price');
  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value, 10);
    if (!isNaN(price) && price >= 300 && price <= 9999999) {
      const addTaxPrice = Math.floor(price * 0.1); // 販売手数料を計算し、小数点以下を切り捨て
      const profit = Math.floor(price - addTaxPrice); // 販売利益を計算し、小数点以下を切り捨て
      addTaxDom.innerHTML = addTaxPrice.toLocaleString(); // 販売手数料を表示
      profitDom.innerHTML = profit.toLocaleString(); // 販売利益を表示
    } else {
      addTaxDom.innerHTML = ''; // 無効な価格の場合は空にする
      profitDom.innerHTML = ''; // 無効な価格の場合は空にする
    }
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);