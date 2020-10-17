package menu;

import java.util.Hashtable;

public class CartManager {
	private Hashtable<String, OrderBean> hCart = new Hashtable<String, OrderBean>();
	
	//카트에 추가
	public void addCart(OrderBean obean){

		//key값 : pd_num, value값 : OrderBean
		String pd_num = obean.getPd_num();
		int amount = Integer.parseInt(obean.getAmount());
		int price = Integer.parseInt(obean.getPrice());

		//주문수량이 0보다 크면
		if(amount > 0){
			//카트에 동일상품이 있으면

			if(hCart.containsKey(pd_num)){
				//카트의 기존 상품번호의 orderbean을 가져옴
				OrderBean tempBean = (OrderBean)hCart.get(pd_num);
				//현재 갯수 + 기존 상품의 갯수
				amount += Integer.parseInt(tempBean.getAmount());
				price += Integer.parseInt(tempBean.getPrice());
				//기존상품 갯수 = 현재갯수 + 기존상품 갯수
				tempBean.setAmount(Integer.toString(amount));
				tempBean.setPrice(Integer.toString(price));

				//카트에 추가
				hCart.put(pd_num, tempBean);

			//카트에 동일상품이 없으면
			} else {
				hCart.put(pd_num, obean);
			}
		}
	}	

	//카트 목록 출력
	public Hashtable<String,OrderBean> getCartList() {
		return hCart;
	}


	//카트 내용 수정
	public void updateCart(OrderBean obean) {
		String pd_num = obean.getPd_num();
		hCart.put(pd_num, obean);
	}

	
	//카트 내용 삭제
	public void deleteCart(OrderBean obean) {
		String pd_num = obean.getPd_num();
		hCart.remove(pd_num);
	}
}