<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gemini - الذكاء الاصطناعي الشامل</title>
    <!-- استيراد الخطوط والأيقونات -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-main: #131314;
            --bg-sidebar: #1e1f20;
            --bg-chat: #1e1f20;
            --bg-input: #282a2c;
            --text-main: #e3e3e3;
            --text-secondary: #c4c7c5;
            --gemini-gradient: linear-gradient(135deg, #4285f4, #9b72cb, #d96570);
            --border-color: #333537;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Cairo', sans-serif;
        }

        body {
            background-color: var(--bg-main);
            color: var(--text-main);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* القائمة الجانبية */
        aside {
            width: 280px;
            background-color: var(--bg-sidebar);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 20px;
            border-left: 1px solid var(--border-color);
            transition: transform 0.3s ease;
            z-index: 100;
        }

        .new-chat-btn {
            background: var(--bg-input);
            border: 1px solid var(--border-color);
            color: var(--text-main);
            padding: 12px 20px;
            border-radius: 30px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 25px;
            transition: background 0.2s;
        }

        .new-chat-btn:hover {
            background: #333538;
        }

        .history-title {
            font-size: 13px;
            color: var(--text-secondary);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .history-list {
            flex-grow: 1;
            overflow-y: auto;
            list-style: none;
        }

        .history-item {
            padding: 10px 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            color: var(--text-secondary);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 5px;
            transition: background 0.2s;
        }

        .history-item:hover {
            background: var(--bg-input);
            color: var(--text-main);
        }

        /* المحتوى الرئيسي */
        main {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
            position: relative;
        }

        header {
            padding: 15px 30px;
            font-size: 20px;
            font-weight: 700;
            background: var(--bg-main);
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 1px solid var(--border-color);
        }

        header i {
            background: var(--gemini-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* حاوية الرسائل */
        .chat-container {
            flex-grow: 1;
            overflow-y: auto;
            padding: 20px 15% 120px 15%;
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .welcome-screen {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
            text-align: center;
            gap: 15px;
        }

        .welcome-screen h1 {
            font-size: 42px;
            background: var(--gemini-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-screen p {
            color: var(--text-secondary);
            font-size: 18px;
        }

        /* رسالة المستخدم والمساعد */
        .message {
            display: flex;
            gap: 15px;
            max-width: 900px;
            width: 100%;
            margin: 0 auto;
            line-height: 1.7;
            font-size: 16px;
        }

        .message.user {
            flex-direction: row-reverse;
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }

        .user .avatar {
            background: #4a5568;
            color: #fff;
        }

        .assistant .avatar {
            background: var(--gemini-gradient);
            color: #fff;
        }

        .content {
            background: var(--bg-chat);
            padding: 15px 20px;
            border-radius: 12px;
            max-width: 80%;
            word-break: break-word;
        }

        .user .content {
            background: var(--bg-input);
            border-top-left-radius: 2px;
        }

        .assistant .content {
            border-top-right-radius: 2px;
        }

        .content img {
            max-width: 100%;
            border-radius: 8px;
            margin-top: 10px;
        }

        /* منطقة إدخال الرسائل */
        .input-area {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(transparent, var(--bg-main) 40%);
            padding: 20px 15% 30px 15%;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .input-box {
            background: var(--bg-input);
            border: 1px solid var(--border-color);
            border-radius: 35px;
            display: flex;
            align-items: center;
            padding: 8px 20px;
            gap: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }

        .input-box textarea {
            flex-grow: 1;
            background: transparent;
            border: none;
            color: var(--text-main);
            font-size: 16px;
            resize: none;
            max-height: 120px;
            outline: none;
            padding: 8px 0;
        }

        .input-tools {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .input-tools button {
            background: transparent;
            border: none;
            color: var(--text-secondary);
            font-size: 18px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .input-tools button:hover {
            color: var(--text-main);
        }

        .send-btn {
            background: #fff !important;
            color: #131314 !important;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .send-btn:hover {
            transform: scale(1.05);
        }

        /* أزرار الاقتراحات السريعة */
        .suggestions {
            display: flex;
            gap: 10px;
            overflow-x: auto;
            padding-bottom: 5px;
        }

        .suggestion-chip {
            background: var(--bg-input);
            border: 1px solid var(--border-color);
            color: var(--text-secondary);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.2s;
        }

        .suggestion-chip:hover {
            background: #333538;
            color: var(--text-main);
        }

        /* شاشة التحميل */
        .typing-indicator span {
            height: 8px;
            width: 8px;
            float: left;
            margin: 0 2px;
            background-color: var(--text-secondary);
            border-radius: 50%;
            display: inline-block;
            animation: bounce 1.3s infinite ease-in-out;
        }
        .typing-indicator span:nth-child(2) { animation-delay: -1.1s; }
        .typing-indicator span:nth-child(3) { animation-delay: -0.9s; }

        @keyframes bounce {
            0%, 60%, 100% { transform: translateY(0); }
            30% { transform: translateY(-6px); }
        }

        @media (max-width: 768px) {
            aside { display: none; }
            .chat-container, .input-area { padding-left: 5%; padding-right: 5%; }
        }
    </style>
</head>
<body>

    <!-- القائمة الجانبية -->
    <aside>
        <div>
            <button class="new-chat-btn" onclick="startNewChat()">
                <i class="fa-solid fa-plus"></i> دردشة جديدة
            </button>
            <div class="history-title">سجل المحادثات</div>
            <ul class="history-list" id="historyList">
                <!-- يتم ملؤها ديناميكياً -->
            </ul>
        </div>
        <div style="font-size: 12px; color: var(--text-secondary); text-align: center;">
            Gemini Universal AI v2.6
        </div>
    </aside>

    <!-- المحتوى الرئيسي -->
    <main>
        <header>
            <i class="fa-solid fa-wand-magic-sparkles"></i>
            <span>Gemini</span>
        </header>

        <div class="chat-container" id="chatContainer">
            <div class="welcome-screen" id="welcomeScreen">
                <h1>أهلاً بك، خلدون</h1>
                <p>كيف يمكنني مساعدتك اليوم؟ اسألني عن أي شخصية، علم، تطبيق، أو اطلب توليد الصور.</p>
            </div>
        </div>

        <div class="input-area">
            <div class="suggestions">
                <div class="suggestion-chip" onclick="sendSuggestion('ارسم لي ملعب كرة قدم بتصميم اسطوري')">🎨 ارسم لي ملعب كرة قدم</div>
                <div class="suggestion-chip" onclick="sendSuggestion('من هو ليونيل ميسي؟ وكيف حقق بطولاته؟')">⚽ من هو ليونيل ميسي؟</div>
                <div class="suggestion-chip" onclick="sendSuggestion('اكتب لي كود بايثون لحساب معدل الطلاب')">💻 كود بايثون ذكي</div>
                <div class="suggestion-chip" onclick="sendSuggestion('اشرح لي نظرية النسبية باختصار')">🌌 شرح نظرية النسبية</div>
            </div>
            <div class="input-box">
                <textarea id="userInput" placeholder="اطرح أي سؤال، اطلب تصميم صورة، أو استفسر عن أي شيء في العالم..." rows="1" oninput="autoResize(this)" onkeydown="handleEnter(event)"></textarea>
                <div class="input-tools">
                    <button title="إرفاق ملف"><i class="fa-solid fa-paperclip"></i></button>
                    <button title="إدخال صوتي"><i class="fa-solid fa-microphone"></i></button>
                    <div class="send-btn" onclick="handleSendMessage()"><i class="fa-solid fa-arrow-up"></i></div>
                </div>
            </div>
        </div>
    </main>

    <script>
        const chatContainer = document.getElementById('chatContainer');
        const welcomeScreen = document.getElementById('welcomeScreen');
        const userInput = document.getElementById('userInput');
        const historyList = document.getElementById('historyList');

        let chatHistory = JSON.parse(localStorage.getItem('gemini_history')) || [];
        renderHistory();

        function autoResize(textarea) {
            textarea.style.height = 'auto';
            textarea.style.height = textarea.scrollHeight + 'px';
        }

        function handleEnter(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                handleSendMessage();
            }
        }

        function sendSuggestion(text) {
            userInput.value = text;
            handleSendMessage();
        }

        function startNewChat() {
            chatContainer.innerHTML = '';
            chatContainer.appendChild(welcomeScreen);
            welcomeScreen.style.display = 'flex';
        }

        async function handleSendMessage() {
            const text = userInput.value.trim();
            if (!text) return;

            if (welcomeScreen) {
                welcomeScreen.style.display = 'none';
            }

            // إضافة رسالة المستخدم
            appendMessage(text, 'user');
            userInput.value = '';
            userInput.style.height = 'auto';

            // حفظ في السجل
            if (!chatHistory.includes(text)) {
                chatHistory.unshift(text);
                localStorage.setItem('gemini_history', JSON.stringify(chatHistory));
                renderHistory();
            }

            // إضافة مؤشر الكتابة
            const loadingId = appendTypingIndicator();

            // معالجة الرد الذكي
            setTimeout(() => {
                removeMessage(loadingId);
                const response = generateSmartResponse(text);
                appendMessage(response.text, 'assistant', response.image);
            }, 1200);
        }

        function generateSmartResponse(query) {
            const q = query.toLowerCase();
            let resText = "";
            let imageUrl = null;

            if (q.includes('ارسم') || q.includes('صورة') || q.includes('تصميم')) {
                resText = "لقد قمت بتوليد الصورة بناءً على طلبك باستخدام محرك الذكاء الاصطناعي البصري:";
                imageUrl = "https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=1000&q=80";
            } else if (q.includes('ميسي') || q.includes('برشلونة') || q.includes('كرة قدم')) {
                resText = "ليونيل ميسي هو أحد أعظم لاعبي كرة القدم في التاريخ. قضى معظم مسيرته مع نادي برشلونة الإسباني وحقق معه ألقاباً أسطورية أبرزها دوري أبطال أوروبا والدوري الإسباني، بالإضافة لتحقيقه كأس العالم مع الأرجنتين عام 2022 في قطر.";
            } else if (q.includes('باثيون') || q.includes('كود') || q.includes('برمجة')) {
                resText = "تفضل كود بلغة بايثون بسيط لحساب المعدل التراكمي أو درجات الطلاب:\n```python\ndef calculate_average(grades):\n    return sum(grades) / len(grades)\n\nstudents_grades = [85, 90, 78, 92]\nprint(f'المعدل هو: {calculate_average(students_grades)}')\n```";
            } else {
                resText = `بناءً على تحليلي لقاعدة المعرفة الشاملة الخاصة بي حول سؤالك ("${query}"): هذا الموضوع يشمل جوانب متعددة ترتبط بالتاريخ، التكنولوجيا، والتطبيقات العملية المعاصرة. يمكننا الغوص في التفاصيل الدقيقة، أو مقارنة البيانات، أو تقديم شخصيات مرتبطة بالمجال إذا أردت التعمق أكثر!`;
            }

            return { text: resText, image: imageUrl };
        }

        function appendMessage(text, sender, imageUrl = null) {
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${sender}`;

            const avatar = document.createElement('div');
            avatar.className = 'avatar';
            avatar.innerHTML = sender === 'user' ? '<i class="fa-solid fa-user"></i>' : '<i class="fa-solid fa-wand-magic-sparkles"></i>';

            const content = document.createElement('div');
            content.className = 'content';
            
            // تنسيق الأسطر وتبرز الأكواد البرمجية
            let formattedText = text.replace(/\n/g, '<br>');
            if (formattedText.includes('```')) {
                formattedText = formattedText.replace(/```python([\s\S]*?)```/g, '<pre style="background:#0b0e14; padding:10px; border-radius:6px; margin-top:8px; direction:ltr; text-align:left; overflow-x:auto;"><code>$1</code></pre>');
            }
            
            content.innerHTML = formattedText;

            if (imageUrl) {
                const img = document.createElement('img');
                img.src = imageUrl;
                content.appendChild(img);
            }

            messageDiv.appendChild(avatar);
            messageDiv.appendChild(content);
            chatContainer.appendChild(messageDiv);
            chatContainer.scrollTop = chatContainer.scrollHeight;

            return messageDiv;
        }

        function appendTypingIndicator() {
            const id = 'loading-' + Date.now();
            const messageDiv = document.createElement('div');
            messageDiv.className = 'message assistant';
            messageDiv.id = id;

            const avatar = document.createElement('div');
            avatar.className = 'avatar';
            avatar.innerHTML = '<i class="fa-solid fa-wand-magic-sparkles"></i>';

            const content = document.createElement('div');
            content.className = 'content';
            content.innerHTML = '<div class="typing-indicator"><span></span><span></span><span></span></div>';

            messageDiv.appendChild(avatar);
            messageDiv.appendChild(content);
            chatContainer.appendChild(messageDiv);
            chatContainer.scrollTop = chatContainer.scrollHeight;

            return id;
        }

        function removeMessage(id) {
            const el = document.getElementById(id);
            if (el) el.remove();
        }

        function renderHistory() {
            historyList.innerHTML = '';
            chatHistory.forEach(item => {
                const li = document.createElement('li');
                li.className = 'history-item';
                li.textContent = item;
                li.onclick = () => {
                    userInput.value = item;
                    handleSendMessage();
                };
                historyList.appendChild(li);
            });
        }
    </script>
</body>
</html>