From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Sat, 24 Jan 2009 16:47:52 +1100
Message-ID: <408431290901232147k55887ecdqf683c57b5ca6b6c3@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1231353304432538816=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232701534.3011.35.camel@zeus.themaw.net>
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

--===============1231353304432538816==
Content-Type: multipart/alternative; boundary=0016e652f4fce549a60461340b2f

--0016e652f4fce549a60461340b2f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

modules/replicated.c:
    303 static int add_host(struct host **list, struct host *host)
...
    307         if (!list) {
    308                 *list = host;
    309                 return 1;
    310         }

That is a NULL pointer dereference.


lib/alarm.c:
    223 int alarm_start_handler(void)
...
    230         status = pthread_attr_init(pattrs);
...
    240         status = pthread_create(&thid, pattrs, alarm_handler, NULL);
    241         if (status)
    242                 return 0;
    243
    244         return 1;

Should you call pthread_attr_destroy(3) before returning?


lib/defaults.c:
    544 struct ldap_searchdn *defaults_get_searchdns(void)
...
    566                         if (!new) {
    567                                 defaults_free_searchdns(sdn);
    568                                 return NULL;
    569                         }

That is a resource leak. (`f' is not closed.)


modules/mount_changer.c:
    142 int swapCD(const char *device, const char *slotName)
...
    161         if (total_slots_available <= 1) {
    162                 logerr(MODPREFIX
    163                       "Device %s is not an ATAPI compliant CD
changer.",
    164                       device);
    165                 return 1;
    166         }
...
    170         if (slot < 0) {
    171                 logerr(MODPREFIX "CDROM_SELECT_DISC failed");
    172                 return 1;
    173         }

Those are resource leaks. (`fd' is not closed.)


daemon/state.c:
   1124 int st_start_handler(void)
...
   1131         status = pthread_attr_init(pattrs);
...
   1141         status = pthread_create(&thid, pattrs, st_queue_handler,
NULL);
   1142         if (status)
   1143                 return 0;
   1144
   1145         return 1;

Should you call pthread_attr_destroy(3) before returning?

--0016e652f4fce549a60461340b2f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

modules/replicated.c:<br>&nbsp;&nbsp;&nbsp; 303 static int add_host(struct =
host **list, struct host *host)<br>...<br>&nbsp;&nbsp;&nbsp; 307&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list) {<br>&nbsp;&nbsp;&nbsp; 30=
8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *list =3D host;<br>&nbsp;&nbsp;&nbsp; 309&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 1;<br>&nbsp;&nbsp;&nbsp; 310&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
<br>That is a NULL pointer dereference.<br><br><br>lib/alarm.c:<br>&nbsp;&n=
bsp;&nbsp; 223 int alarm_start_handler(void)<br>...<br>&nbsp;&nbsp;&nbsp; 2=
30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D pthread_attr_=
init(pattrs);<br>...<br>&nbsp;&nbsp;&nbsp; 240&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; status =3D pthread_create(&amp;thid, pattrs, alarm_hand=
ler, NULL);<br>
&nbsp;&nbsp;&nbsp; 241&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
status)<br>&nbsp;&nbsp;&nbsp; 242&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&nbsp;&=
nbsp;&nbsp; 243 <br>&nbsp;&nbsp;&nbsp; 244&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 1;<br><br>Should you call pthread_attr_destroy(3) be=
fore returning?<br><br><br>lib/defaults.c:<br>&nbsp;&nbsp;&nbsp; 544 struct=
 ldap_searchdn *defaults_get_searchdns(void)<br>
...<br>&nbsp;&nbsp;&nbsp; 566&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (!new) {<br>&nbsp;&nbsp;&nbsp; 567&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; defaults_free_searchdns(sdn);<br>&nbsp;&nbsp;&=
nbsp; 568&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>&nbsp;&=
nbsp;&nbsp; 569&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }<br><br>
That is a resource leak. (`f&#39; is not closed.)<br><br><br>modules/mount_=
changer.c:<br>&nbsp;&nbsp;&nbsp; 142 int swapCD(const char *device, const c=
har *slotName)<br>...<br>&nbsp;&nbsp;&nbsp; 161&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (total_slots_available &lt;=3D 1) {<br>&nbsp;&nbsp;=
&nbsp; 162&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logerr(MODPREFIX<br>
&nbsp;&nbsp;&nbsp; 163&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;Device %s is not an ATAPI compliant CD changer.&quot;,<br>&nbsp;=
&nbsp;&nbsp; 164&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
evice);<br>&nbsp;&nbsp;&nbsp; 165&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<br>&nbsp;&=
nbsp;&nbsp; 166&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>...<br=
>&nbsp;&nbsp;&nbsp; 170&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(slot &lt; 0) {<br>
&nbsp;&nbsp;&nbsp; 171&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logerr(MODPREFIX &quot;CDROM_SE=
LECT_DISC failed&quot;);<br>&nbsp;&nbsp;&nbsp; 172&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn 1;<br>&nbsp;&nbsp;&nbsp; 173&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br><br>Those are resource leaks. (`fd&#39; is not closed.)<br><br><=
br>daemon/state.c:<br>
&nbsp;&nbsp; 1124 int st_start_handler(void)<br>...<br>&nbsp;&nbsp; 1131&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D pthread_attr_init(=
pattrs);<br>...<br>&nbsp;&nbsp; 1141&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; status =3D pthread_create(&amp;thid, pattrs, st_queue_handler, NU=
LL);<br>&nbsp;&nbsp; 1142&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (status)<br>
&nbsp;&nbsp; 1143&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&nbsp;&nbsp; 1144 <br>&=
nbsp;&nbsp; 1145&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<=
br><br>Should you call pthread_attr_destroy(3) before returning?<br>

--0016e652f4fce549a60461340b2f--


--===============1231353304432538816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1231353304432538816==--

