document.addEventListener("DOMContentLoaded", () => {
	// Перевіряємо, чи ми на сторінці входу
	if (document.body.id === "sessions-new") {
		const errorMessagesContainer = document.getElementById("error-messages");

		if (errorMessagesContainer) {
			// Відображаємо повідомлення Bootstrap
			errorMessagesContainer.classList.add("show");
		}
	}
});
