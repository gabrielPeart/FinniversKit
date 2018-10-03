//
//  Copyright © 2018 FINN AS. All rights reserved.
//
import FinniversKit

struct ConsentViewData: ConsentViewModel {
    var title: String? = "Få nyhetsbrev fra FINN"
    var state = true
    var text = "FINN sender deg nyhetsbrev med for eksempel reisetips, jobbtrender, morsomme konkurranser og smarte råd til deg som kjøper og selger.\nFor å gjøre dette bruker vi kontaktinformasjonen knyttet til brukeren din på FINN."
    var buttonTitle = "Les mer"
    var buttonStyle = Button.Style.flat
    var indexPath = IndexPath(row: 0, section: 0)
}

class ConsentViewDemoView: UIView {

    private lazy var consentDetailView: ConsentView = {
        let view = ConsentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.model = ConsentViewData()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(consentDetailView)
        consentDetailView.fillInSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
