module DomainsHelper

  def find_user_domain user, domain
    UserDomain.find_by user_id: user.id, domain_id: @choosen_domain.id
  end

  def delete_user_domain_btn user_domain
    link_to t("delete"), user_domain_path(user_domain,
      domain_id: user_domain.domain_id, delete_user_domain: true),
      data: {destroy: "user-domain", "domain-name": user_domain.domain_name,
        "user-name": user_domain.user_name}, class: "btn btn-danger btn-delete-user"
  end

  def domain_manager_action user_domain
    if user_domain.member?
      role = :manager
      text = t("manage_domain.manage")
      classes = "btn btn-primary"
    else
      role = :member
      text = t("manage_domain.remove")
      classes = "btn btn-primary btn-warning"
    end
    link_to text,
      user_domain_path(user_domain, role: role),
      method: :patch, class: classes, remote: true
  end

  def owner_name domain
    user = User.find_by id: domain.owner
    user.present? ? user.name : ""
  end

  def load_tag_status domain
    if domain.secret?
      label_tag "", t("secret"), class: "domain-secret"
    else
      label_tag "", t("professed"), class: "domain-professed"
    end
  end
end
