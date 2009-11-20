From: Cove Schneider <cove_s@yahoo.com>
Subject: Resolved autofs + AD DIGEST-MD5 integration issue
Date: Fri, 20 Nov 2009 12:57:58 -0800 (PST)
Message-ID: <660637.19535.qm@web110601.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1697737794707881797=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1258750678; bh=DsKTAei5raZPxh7jcmsCBAdfBjmW26GJ4b+JDVwZvgI=;
	h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
	b=rYQH812psBSsmV2/yfyFlfm5R3hNA3sPPp9TY578mMiae6fwIDfqTYBO/WgMFKZTM7OMh5LVRbCd4Cju3UbRwplaP9sCeGAulwLCvCcrXORRqqDo49wzZGU3sJpkelARM7NbHDT0X2nxCCCC4wCI4F0mqlzCDuN4SiV5B4zad6o=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============1697737794707881797==
Content-Type: multipart/alternative; boundary="0-180168936-1258750678=:19535"

--0-180168936-1258750678=:19535
Content-Type: text/plain; charset=us-ascii

Autofs not being able to bind to AD using DIGEST-MD5 will be resolved in Windows 2008 onward. This was due to AD accidentally indicating it supported subsequent authentication when it didn't.

Hot fix:
http://support.microsoft.com/kb/975697

Original issue:
http://linux.kernel.org/pipermail/autofs/2009-January/005527.html

Cove



      
--0-180168936-1258750678=:19535
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt"><div><div style="">Autofs not being able to bind to AD using DIGEST-MD5 will be resolved in Windows 2008 onward. This was due to AD accidentally indicating it supported subsequent authentication when it didn't.<br><span style="background-color: white;" lang="en-US"><font size="1" color="black" face="Tahoma"><span style="font-size: 13px;" dir="ltr">

<br>Hot fix:<br><span><a target="_blank" href="http://support.microsoft.com/kb/975697">http://support.microsoft.com/kb/975697</a></span><br><br></span></font></span>Original issue:<br><span><a target="_blank" href="http://linux.kernel.org/pipermail/autofs/2009-January/005527.html">http://linux.kernel.org/pipermail/autofs/2009-January/005527.html</a></span><br><br>Cove<br></div></div>
<!-- cg39.c4.mail.gq1.yahoo.com compressed/chunked Fri Nov 20 12:47:52 PST 2009 -->
</div><br>



      </body></html>
--0-180168936-1258750678=:19535--


--===============1697737794707881797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1697737794707881797==--

