function download {
  mkdir -p pdf
  mkdir -p excel
  rm pdf/_list.txt
  rm excel/_list.txt
  touch pdf/_list.txt
  touch excel/_list.txt

  excel_start="2021-05-27"
  pdf_start="2020-04-28"
  end=`date +%Y-%m-%d`

  while ! [[ $pdf_start > $end ]]; do
    pdf_url_date=$(date -j -f %Y-%m-%d $pdf_start +%Y%m%d)
    echo "https://www.chp.gov.hk/files/pdf/local_situation_covid19_en_$pdf_url_date.pdf" | cat >> pdf/_list.txt
    pdf_start=$(date -j -v+1d -f %Y-%m-%d $pdf_start +%Y-%m-%d)
  done

  while ! [[ $excel_start > $end ]]; do
    excel_url_date=$(date -j -f %Y-%m-%d $excel_start +%Y%m%d)
    echo "https://www.chp.gov.hk/files/xls/previous_cases_covid19_en_$excel_url_date.xlsx" | cat >> excel/_list.txt
    excel_start=$(date -j -v+1d -f %Y-%m-%d $excel_start +%Y-%m-%d)
  done

  wget --no-clobber --no-verbose --directory-prefix="pdf" -i pdf/_list.txt
  wget --no-clobber --no-verbose --directory-prefix="excel" -i excel/_list.txt
}

download