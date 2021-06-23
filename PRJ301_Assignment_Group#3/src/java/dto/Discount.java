/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.util.Date;

/**
 *
 * @author phamv
 */
public class Discount {
   private int idDiscount;
   private String nameDiscount;
   private int percent;
   private String keyword;
   private Date dateStart;
   private Date dateFinish;

    public Discount() {
    }

    public Discount(int idDiscount, String nameDiscount, int percent, String keyword, Date dateStart, Date dateFinish) {
        this.idDiscount = idDiscount;
        this.nameDiscount = nameDiscount;
        this.percent = percent;
        this.keyword = keyword;
        this.dateStart = dateStart;
        this.dateFinish = dateFinish;
    }

    public int getIdDiscount() {
        return idDiscount;
    }

    public void setIdDiscount(int idDiscount) {
        this.idDiscount = idDiscount;
    }

    public String getNameDiscount() {
        return nameDiscount;
    }

    public void setNameDiscount(String nameDiscount) {
        this.nameDiscount = nameDiscount;
    }

    public int getPercent() {
        return percent;
    }

    public void setPercent(int percent) {
        this.percent = percent;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Date getDateFinish() {
        return dateFinish;
    }

    public void setDateFinish(Date dateFinish) {
        this.dateFinish = dateFinish;
    }

    @Override
    public String toString() {
        return "Discount{" + "idDiscount=" + idDiscount + ", nameDiscount=" + nameDiscount + ", percent=" + percent + ", keyword=" + keyword + ", dateStart=" + dateStart + ", dateFinish=" + dateFinish + '}';
    }
   
}
