From: "idiot)_) supreme" <ejw50@hotmail.com>
Subject: Re: error in 2.6
Date: Fri, 30 Apr 2004 20:12:54 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <SEA2-F70z3T4nwFYHwP00005275@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60660755190881455=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: raven@themaw.net
Cc: autofs@linux.kernel.org

--===============60660755190881455==
Content-Type: text/html

<html><div style='background-color:'><DIV class=RTE>
<P><BR>Thanks Ian.&nbsp; I will repatch the kernel, move up autofs versions, and let you know how it goes.</P>
<P>&nbsp;</P>
<P><BR>&nbsp;</P></DIV>
<DIV></DIV>&gt;From: raven@themaw.net 
<DIV></DIV>&gt;To: "idiot)_) supreme" &lt;ejw50@hotmail.com&gt; 
<DIV></DIV>&gt;CC: autofs@linux.kernel.org 
<DIV></DIV>&gt;Subject: Re: [autofs] error in 2.6 
<DIV></DIV>&gt;Date: Thu, 29 Apr 2004 21:28:57 +0800 (WST) 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;On Wed, 28 Apr 2004, idiot)_) supreme wrote: 
<DIV></DIV>&gt; 
<DIV></DIV>&gt; &gt; I am running autofs4.1, kernel 2.6.5, with the ~7 or so patches.&nbsp;&nbsp;I got this error today 
<DIV></DIV>&gt; &gt; (/net/d4m/ears is an automount directory).&nbsp;&nbsp;It logged me out, then when I tried on a different 
<DIV></DIV>&gt; &gt; directory I got the second error&nbsp;&nbsp;and got kicked out again.&nbsp;&nbsp;I did not do any further 
<DIV></DIV>&gt; &gt; debugging, but I thought you might want to know.&nbsp;&nbsp;If there's anything you want me to try, let 
<DIV></DIV>&gt; &gt; me know. 
<DIV></DIV>&gt; &gt; 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;What revision are you using. 
<DIV></DIV>&gt;You need the 20040417 set. 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;Please inspect the file fs/autofs4/root.c and look for: 
<DIV></DIV>&gt; 
<DIV></DIV>&gt; int flags = nd ? nd-&gt;flags : 0; 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;in the declarations near the top of the function autofs4_revalidate. 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;If you haven't got this you have a broken version of the patches. 
<DIV></DIV>&gt; 
<DIV></DIV>&gt;Ian 
<DIV></DIV>&gt; 
<DIV></DIV></div><br clear=all><hr> <a href="http://g.msn.com/8HMAENUS/2749??PS=">Getting married? Find tips, tools and the latest trends at MSN Life Events.</a> </html>


--===============60660755190881455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============60660755190881455==--
