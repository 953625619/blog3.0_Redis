
var url = getContentPath() + "/checkLogin";
var click = false;
$(
    function () {
        $(".loginButtonAjax").click(
            function () {
                var url = $("#loginForm").attr("action");
                var name = $("#loginName").val();
                var pass = $("#loginPass").val();
                var user = {
                    "userName": name,
                    "userPassword": pass
                };
                $.ajax(
                    {
                        type: "post",
                        url: url,
                        dataType: "json",
                        contentType: "application/json;charset=utf8",
                        data: JSON.stringify(user),
                        success: function (data) {
                            if (data.result == "fail")
                                $(".errorDIV").show();
                            else
                                location.reload();
                        }
                    }
                );
                return false;
            }
        );
        $(".commentText").click(
            function () {
                var comment = $(this);
                $.ajax(
                    {
                        type: "get",
                        url: url,
                        dataType: "json",
                        success: function (data) {
                            if (data.result == "no")
                                $("#loginModel").modal("show");
                            else
                                comment.focus();
                        }
                    }
                );
            }
        );
        $("#addComment").click(
            function () {
                var button = $(this);
                $.ajax(
                    {
                        type: "get",
                        url: url,
                        dataType: "json",
                        success: function (data) {
                            if (data.result == "no")
                                $("#loginModel").modal("show");
                            else {
                                var comment = button.prev().prev().prev().val().trim();
                                var aid = $("#aid").val();
                                var pid = 0;
                                var json = {
                                    "comment": comment,
                                    "aid": aid,
                                    "pid": pid
                                };
                                var url = getContentPath() + "/commitComment";
                                $.ajax(
                                    {
                                        type: "post",
                                        url: url,
                                        dataType: "json",
                                        contentType: "application/json;charset=utf8",
                                        data: JSON.stringify(json),
                                        success: function (data) {
                                            if (data.result == "success")
                                                location.reload();
                                            else
                                                console.log(data);
                                        }
                                    }
                                );
                            }
                        }
                    }
                );
                return false;
            }
        );
        $(".response").click(
            function () {
                var res = $(this);
                $.ajax(
                    {
                        type: "get",
                        url: url,
                        dataType: "json",
                        success: function (data) {
                            if (data.result == "no")
                                $("#loginModel").modal("show");
                            else {
                                if (!click) {
                                    res.parent().parent().next().slideToggle();
                                    res.parent().parent().next().children().focus();
                                    click = !click;
                                }
                                else {
                                    res.parent().parent().next().slideToggle();
                                    click = !click;
                                }
                            }
                        }
                    }
                );
                return false
            }
        );
        $(".addResponse").click(
            function () {
                var comment = $(this).prev().prev().prev().val().trim();
                var aid = $("#aid").val();
                var pid = $(this).prev().val();
                var json = {
                    "comment": comment,
                    "aid": aid,
                    "pid": pid
                };
                var url = getContentPath() + "/commitComment";
                $.ajax(
                    {
                        type: "post",
                        url: url,
                        dataType: "json",
                        contentType: "application/json;charset=utf8",
                        data: JSON.stringify(json),
                        success: function (data) {
                            if (data.result == "success")
                                location.reload();
                        }
                    }
                );
            }
        );

    }
);