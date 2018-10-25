$(
    function () {
        $(".dropdown-menu li a").click(
            function () {
                var text = $(this).text();
                $(this).parent().parent().prev().html(text + "<span class=\"caret\"></span>");
            }
        );
        var path = location.pathname;
        path = path.substr(0, path.substr(1).indexOf("/") + 1);


        // var testEditormdView;
        // $(function () {
        //     testEditormdView = editormd.markdownToHTML("doc-content", {//注意：这里是上面DIV的id
        //         htmlDecode: "style,script,iframe",
        //         emoji: true,
        //         taskList: true,
        //         tex: true, // 默认不解析
        //         flowChart: true, // 默认不解析
        //         sequenceDiagram: true, // 默认不解析
        //         codeFold: true
        //     });
        // });

    }
);