From: Paul Wankadia <junyer@google.com>
Subject: problems in daemon/lookup.c
Date: Tue, 20 Jan 2009 16:48:50 +1100
Message-ID: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8238147250629707282=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--===============8238147250629707282==
Content-Type: multipart/alternative; boundary=001485f02570f952d00460e3972a

--001485f02570f952d00460e3972a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A friend of mine was kind enough to run some analysis for me. A couple of
problems jumped out immediately.


    991 static char *make_fullpath(const char *root, const char *key)
...
   1000                 path = malloc(l);
   1001                 strcpy(path, key);
...
   1006                 path = malloc(l);
   1007                 sprintf(path, "%s/%s", root, key);

Those are unchecked malloc(3) calls. How would you prefer to handle
failures?


   1012 int lookup_prune_cache(struct autofs_point *ap, time_t age)
...
   1075                                 cache_unlock(mc);
   1076                                 free(key);
   1077                                 if (next_key)
   1078                                         free(next_key);
   1079                                 free(path);
   1080                                 goto next;
...
   1103 next:
   1104                         cache_readlock(mc);
   1105                         me = cache_lookup_distinct(mc, next_key);
   1106                         free(key);
   1107                         free(path);
   1108                         free(next_key);

Those are double free(3) calls. Oh, and `next_key' is used after being
freed.

--001485f02570f952d00460e3972a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A friend of mine was kind enough to run some analysis for me. A couple of p=
roblems jumped out immediately.<br><br><br>&nbsp;&nbsp;&nbsp; 991 static ch=
ar *make_fullpath(const char *root, const char *key)<br>...<br>&nbsp;&nbsp;=
 1000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; path =3D malloc(l);<br>
&nbsp;&nbsp; 1001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(path, key);<br>...<br>&nbsp;&=
nbsp; 1006&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path =3D malloc(l);<br>&nbsp;&nbsp; 1007&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; sprintf(path, &quot;%s/%s&quot;, root, key);<br><br>Thos=
e are unchecked malloc(3) calls. How would you prefer to handle failures?<b=
r>
<br><br>&nbsp;&nbsp; 1012 int lookup_prune_cache(struct autofs_point *ap, t=
ime_t age)<br>...<br>&nbsp;&nbsp; 1075&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; cache_unlock(mc);<br>&nbsp;&nbsp; 1076&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; free(key);<br>&nbsp;&nbsp; 1077&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (next_key)<br>
&nbsp;&nbsp; 1078&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(next_key);<br>&nbsp;&nbsp; 1079&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(path);<br>&nbsp;&nbsp; 1080&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto next;<br>...<br>&nbsp;&nbsp; 1103=
 next:<br>&nbsp;&nbsp; 1104&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cache_readlock(mc);<br>
&nbsp;&nbsp; 1105&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; me =3D cache_lookup_distinct(mc, next_key);<br>&nbsp;&nbsp; 110=
6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free=
(key);<br>&nbsp;&nbsp; 1107&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; free(path);<br>&nbsp;&nbsp; 1108&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(next_key);<br>
<br>Those are double free(3) calls. Oh, and `next_key&#39; is used after be=
ing freed.<br>

--001485f02570f952d00460e3972a--


--===============8238147250629707282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8238147250629707282==--

