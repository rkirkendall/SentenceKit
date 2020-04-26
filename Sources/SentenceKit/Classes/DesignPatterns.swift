//
//  DesignPatterns
//  SentenceKit
//
// Design patterns and useful extensions from Anthony Persaud's Modernistik Cocoa framework
// https://github.com/modernistik/cocoa

#if canImport(UIKit)
import UIKit


open class BaseViewController : UIViewController {
    private var needsSetupConstraints = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.setNeedsUpdateConstraints()
    }
    
    open func setupConstraints() {}
    
    override open func updateViewConstraints() {
        
        if needsSetupConstraints {
            needsSetupConstraints = false
            setupConstraints()
        }
        // According to Apple's doc, it should be called as the final step in the
        // implementation.
        super.updateViewConstraints()
    }
    
    open func updateInterface() {}
}

open class BaseView: UIView {
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc public required init(autolayout: Bool) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = !autolayout
        setupView()
    }
    
    @objc open override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    /// Method where the view should be setup once.
    @objc open func setupView() {
        backgroundColor = .clear
        setNeedsUpdateConstraints()
    }
    
    /// This method should implement setting up the autolayout constraints, if any, for the subviews that
    /// were added in `setupView()`. This method is only called once in the view's lifecycle in `updateConstraints()`
    /// layout pass through an internal flag.
    ///
    /// - note: Do not call `setNeedsUpdateConstraints()` inside your implementation.
    /// Calling `setNeedsUpdateConstraints()` may schedule another update pass, creating a feedback loop.
    /// - note: If you do not want to inherit the parent's layout constraints in your subclass, you should not
    /// call the super implementation.
    @objc open func setupConstraints() {}
    
    private var needsSetupConstraints = true
    @objc open override func updateConstraints() {
        super.updateConstraints()
        if needsSetupConstraints {
            needsSetupConstraints = false
            setupConstraints()
        }
    }
    
    /// This method should be called whenever there is a need to update the interface.
    @objc open func updateInterface() {
        setNeedsDisplay()
    }
    
    /// This method should be called whenever there is a need to reset the interface.
    @objc open func prepareForReuse() {}
    
}

extension String {
    /// Uses the string as a NSLayoutConstraint visual format specification for constraints. For more information,
    /// see Auto Layout Cookbook in Auto Layout Guide.
    /// - parameter opts: Options describing the attribute and the direction of layout for all objects in the visual format string.
    /// - parameter metrics: A dictionary of constants that appear in the visual format string. The dictionary’s keys must be the string
    ///   values used in the visual format string. Their values must be NSNumber objects.
    /// - parameter views: A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
    /// - returns: An array of NSLayoutConstraints that were parsed from the string.
    public func constraints(options opts: NSLayoutConstraint.FormatOptions = [], metrics: [String : Any]? = nil, views: [String : Any]) -> [NSLayoutConstraint] {
        // NOTE: If you exception breakpoint hits here, go back one call stack to see the constraint that is causing the error.
        return NSLayoutConstraint.constraints(withVisualFormat: self, options: opts, metrics: metrics, views: views)
    }
    
    /// Uses the string as a NSLayoutConstraint visual format with no options or metrics.
    /// - parameter opts: Options describing the attribute and the direction of layout for all objects in the visual format string.
    /// - parameter views: A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
    /// - returns: An array of NSLayoutConstraints that were parsed from the string.
    public func constraints(options opts: NSLayoutConstraint.FormatOptions, views: [String : Any]) -> [NSLayoutConstraint] {
        // NOTE: If you exception breakpoint hits here, go back one call stack to see the constraint that is causing the error.
        return NSLayoutConstraint.constraints(withVisualFormat: self, options: opts, metrics: nil, views: views)
    }
}

extension UIView {
    /// Returns an zero frame instance ready for autolayout.
    /// # Example
    /// ```
    /// // How to instantiate while subscribing to autolayout
    /// let view = UIView(autolayout: true)
    /// ```
    /// - parameter autolayout: true or false whether this view will be used in autolayout. If true is passed (default), `translatesAutoresizingMaskIntoConstraints` will be set to false.
    @objc public convenience init(autolayout: Bool) {
        self.init(frame: .zero)
        if autolayout { // if true, set to false, otherwise leave default value.
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
#endif
