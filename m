From: Thierry BULTEL <thierry.bultel@wanadoo.fr>
Subject: autofs design doc ?
Date: Fri, 22 Aug 2008 15:51:14 +0200 (CEST)
Message-ID: <15446204.32971219413074178.JavaMail.www@wwinf2610>
Reply-To: Thierry BULTEL <thierry.bultel@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3287538688167340088=="
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
To: autofs@linux.kernel.org

--===============3287538688167340088==
Content-Type: multipart/alternative; 
	boundary="----=_Part_2431_12836133.1219413074148"

------=_Part_2431_12836133.1219413074148
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


 Hi all,

I am currently looking at autofs, and
I would be interested to know if there exist such a documentation.
Namely, I am performing a kind of reverse-engineering on both the daemon 
and the kernel parts.

What I would like to understand, above all, is the detailed interaction 
scheme between automount and the kernel.
I have understood that automount was receiving orders through a pipe, 
and replying with ioctls, but
I still do not have the complete vision of the nature and timing of the 
messages. What are the respective responsibilities
of both parts ?
Also, I am still asking myself why a user daemon is used, and why not 
everything is not done in the kernel.

Any help would be really appreciated !

Thanks,
Thierry Bultel 
------=_Part_2431_12836133.1219413074148
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<p style="margin:0;padding:0;" align="left"><br /> <pre>Hi all,<br /><br />I am currently looking at autofs, and<br />I would be interested to know if there exist such a documentation.<br />Namely, I am performing a kind of reverse-engineering on both the daemon <br />and the kernel parts.<br /><br />What I would like to understand, above all, is the detailed interaction <br />scheme between automount and the kernel.<br />I have understood that automount was receiving orders through a pipe, <br />and replying with ioctls, but<br />I still do not have the complete vision of the nature and timing of the <br />messages. What are the respective responsibilities<br />of both parts ?<br />Also, I am still asking myself why a user daemon is used, and why not <br />everything is not done in the ke
 rnel.<br /><br />Any help would be really appreciated !<br /><br />Thanks,<br />Thierry Bultel</pre> </p>
------=_Part_2431_12836133.1219413074148--



--===============3287538688167340088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3287538688167340088==--


