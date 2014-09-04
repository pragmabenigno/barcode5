require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ScanController < Rho::RhoController
  include BrowserHelper

  # GET /Scan
  def index
    @scans = Scan.find(:all)
    render :back => '/app'
  end

  def scan_received
    if @params["status"] == "ok"
      Rho::Log.info(@params["barcode"],"Barcode result")
    else
      Rho::Log.info("canceled", "Barcode result")
    end
  end

  def scan_barcode
    Rho::Barcode.take({}, url_for(:action => :scan_received))
  end

end
