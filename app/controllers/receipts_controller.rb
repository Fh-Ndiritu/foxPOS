require "prawn"
require "prawn/measurement_extensions"
include ActionView::Helpers::NumberHelper

class ReceiptsController < ApplicationController
  def show
    order = Order.find(params[:id]) # Fetch order details

    estimated_height = (order.items.count * 30) + 350
    pdf = Prawn::Document.new(page_size: [ 227, estimated_height ], margin: 10)

    # Logo path (Ensure the file exists)
    logo_path = Rails.root.join("app/assets/images/logos/logo.jpg")

    # Business title and motto
    business_title = "JUICE ARENA"
    business_subtitle = "Juices, Shakes & Cream"
    business_motto = "Taste The Difference!"

    # Additional business details
    additional_details = "Located at: 9 Park Square, Ridgeways.\nFor Deliveries, Contact: 0718 444 522"

    # Header Section
    pdf.bounding_box([ 0, pdf.bounds.top ], width: pdf.bounds.width) do
      if File.exist?(logo_path)
        pdf.image logo_path, at: [ 10, pdf.bounds.top ], width: 40, height: 40
      else
        pdf.draw_text "LOGO", at: [ 10, pdf.bounds.top - 20 ], size: 10
      end

      pdf.draw_text business_title, at: [ 60, pdf.bounds.top - 10 ], size: 12, style: :bold
      pdf.draw_text business_subtitle, at: [ 60, pdf.bounds.top - 25 ], size: 10
      pdf.draw_text business_motto, at: [ 60, pdf.bounds.top - 40 ], size: 8, style: :bold
    end

    pdf.move_down 60

    # Additional Business Details
    pdf.text additional_details, size: 8, align: :left

    pdf.move_down 10
    pdf.text "-" * 35, align: :center, size: 8

    # Order Details
    pdf.text "Date: #{order.created_at.strftime('%d %b %Y, %H:%M:%S')}", size: 8, align: :left
    pdf.text "Served By: #{order.server_name}", size: 8, align: :left

    pdf.move_down 10

    # Table for items
    table_data = [ [ "Item", "Price", "Qty", "Value" ] ]
    order.items.each do |item|
      table_data << [ item.name, format_currency(item.price), "x#{item.quantity}", format_currency(item.price) ]
    end
    pdf.table(table_data, width: pdf.bounds.width - 20, header: true, cell_style: { borders: [], size: 8, padding: [ 2, 5 ] })

    pdf.move_down 10
    pdf.text "-" * 35, align: :center, size: 8

    # Total and Payment Information
    pdf.text "Total Paid", align: :center, size: 10, style: :bold
    pdf.text format_currency(order.total), align: :center, size: 12, style: :bold

    pdf.move_down 10
    pdf.text "-" * 35, align: :center, size: 8

    pdf.text "M-PESA TILL NUMBER: 4960822", align: :center, size: 9, style: :bold

    pdf.move_down 10
    pdf.text "Juice Arena", align: :center, size: 8
    pdf.text "Karibu Tena, God bless!", align: :center, size: 8

    send_data pdf.render, filename: "Receipt_#{order.id}.pdf", type: "application/pdf"
  end


  private

 def format_currency(amount)
  number_to_currency(amount, unit: "KES ", delimiter: ",", separator: ".")
 end
end
