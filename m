From: "Sanjay Sha" <sanjay.sha@gmail.com>
Subject: how does this work?
Date: Tue, 13 Mar 2007 16:29:03 +0530
Message-ID: <c80174f10703130359o45f0a547r6b620e862fa4de14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8459037981882158304=="
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

--===============8459037981882158304==
Content-Type: multipart/alternative; 
	boundary="----=_Part_19688_104864.1173783543966"

------=_Part_19688_104864.1173783543966
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the scenario::
~~~~~~~~~~~~~~~~

myhome.nfs is a CNAME to myweb.apla.com
(myhome.nfs.apla.com is a CNAME to myweb.apla.com)

autofs config looks like this::

/auto/myhome    myhome.nfs:/home/sanjay

on the same client machine::

/etc/resolv.conf has
search apla.com
nameserver 10.10.10.245
nameserver 10.10.10.244

now ping to myhome.nfs gives

PING myweb.apla.com (10.10.10.12) 56(84) bytes of data
64 bytes from myweb.apla.com (10.10.10.12) : icmp_seq=1 ttl=254 time=0.132ms

When I do this..

tech-sanjay:/auto$ cd myhome
-bash: cd: myhome: No such file or directory

I am trying to understand how the automount deamon handles the requests... I
am curious to know how the DNS resolution part is handled..

Your help will be greatly appreciated..

Thank you,
Sanjay

-- 
49:02:1f:d9:d5:10:98:58:12:af:56:e4:f1:34:cf:7e -Sunj
www.sanjaysha.com

------=_Part_19688_104864.1173783543966
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the scenario::<br>~~~~~~~~~~~~~~~~<br><br>myhome.nfs is a CNAME to <a href="http://myweb.apla.com">myweb.apla.com</a><br>(<a href="http://myhome.nfs.apla.com">myhome.nfs.apla.com</a> is a CNAME to <a href="http://myweb.apla.com">
myweb.apla.com</a>)<br><br>autofs config looks like this::<br><br><span style="font-style: italic;">/auto/myhome&nbsp;&nbsp;&nbsp; myhome.nfs:/home/sanjay</span><br><br>on the same client machine::<br><br><span style="font-style: italic;">
/etc/resolv.conf has </span><br style="font-style: italic;"><span style="font-style: italic;">search <a href="http://apla.com">apla.com</a> </span><br style="font-style: italic;"><span style="font-style: italic;">nameserver 
<a href="http://10.10.10.245">10.10.10.245</a></span><br style="font-style: italic;"><span style="font-style: italic;">nameserver <a href="http://10.10.10.244">10.10.10.244</a></span><br style="font-style: italic;"><br>now ping to 
myhome.nfs gives<br><br><span style="font-style: italic;">PING <a href="http://myweb.apla.com">myweb.apla.com</a> (<a href="http://10.10.10.12">10.10.10.12</a>) 56(84) bytes of data</span><br style="font-style: italic;"><span style="font-style: italic;">
64 bytes from <a href="http://myweb.apla.com">myweb.apla.com</a> (<a href="http://10.10.10.12">10.10.10.12</a>) : icmp_seq=1 ttl=254 time=0.132ms</span><br style="font-style: italic;"><br>When I do this..<br><br><span style="font-style: italic;">
tech-sanjay:/auto$ cd myhome</span><br style="font-style: italic;"><span style="font-style: italic;">-bash: cd: myhome: No such file or directory</span><br><br>I am trying to understand how the automount deamon handles the requests... I am curious to know how the DNS resolution part is handled..
<br><br>Your help will be greatly appreciated..<br><br>Thank you,<br>Sanjay<br clear="all"><br>-- <br>49:02:1f:d9:d5:10:98:58:12:af:56:e4:f1:34:cf:7e -Sunj<br><a href="http://www.sanjaysha.com">www.sanjaysha.com</a>

------=_Part_19688_104864.1173783543966--


--===============8459037981882158304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8459037981882158304==--

