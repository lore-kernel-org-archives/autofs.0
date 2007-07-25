From: Howard Wilkinson <howard@cohtech.com>
Subject: Autofs 4 and 5 with nfs4
Date: Wed, 25 Jul 2007 13:45:09 +0100
Message-ID: <46A745D5.7080603@cohtech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5966101029936249562=="
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

This is a multi-part message in MIME format.
--===============5966101029936249562==
Content-Type: multipart/alternative;
	boundary="------------000104050509050308090601"

This is a multi-part message in MIME format.
--------------000104050509050308090601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have a site that is currently using NFS4 for most of its traffic. We 
have a mix of autofs4 and autofs5 clients. The following map is used to 
provide access to host filing system exports

Auto.master:

/hosts     auto.hosts

auto.hosts

*       -fstype=nfs4,tcp,rsize=32768,wsize=32768,hard,intr,nodev,nosuid &:/

This works fine in both autofs4 and autofs5 if the client is not the 
server (i.e. loopback ...) However with autofs5 this returns the root of 
the local file system not the exported nfs4 root.

Is there a map syntax that would work round this? Ideally I would like 
the map to be the same on all hosts, I can have different maps on the 
autofs4 and autofs5 hosts easily but would not want to have a separate 
map per host.
-- 

Howard Wilkinson

	

Phone:

	

+44(20)76907075

Coherent Technology Limited

	

Fax:

	

 

23 Northampton Square,

	

Mobile:

	

+44(7980)639379

United Kingdom, EC1V 0HL

	

Email:

	

howard@cohtech.com

 


--------------000104050509050308090601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I have a site that is currently using NFS4 for most of its traffic. We
have a mix of autofs4 and autofs5 clients. The following map is used to
provide access to host filing system exports<br>
<br>
Auto.master:<br>
<br>
/hosts&nbsp;&nbsp;&nbsp;&nbsp; auto.hosts<br>
<br>
auto.hosts<br>
<br>
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -fstype=nfs4,tcp,rsize=32768,wsize=32768,hard,intr,nodev,nosuid
&amp;:/<br>
<br>
This works fine in both autofs4 and autofs5 if the client is not the
server (i.e. loopback ...) However with autofs5 this returns the root
of the local file system not the exported nfs4 root.<br>
<br>
Is there a map syntax that would work round this? Ideally I would like
the map to be the same on all hosts, I can have different maps on the
autofs4 and autofs5 hosts easily but would not want to have a separate
map per host.<br>
<div class="moz-signature">-- <br>
<title>Signature</title>
<div class="Section1">
<table class="MsoNormalTable" style="width: 100%;" border="0"
 cellpadding="0" width="100%">
  <tbody>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Howard Wilkinson</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Phone:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">+44(20)76907075</p>
      </td>
    </tr>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Coherent Technology Limited</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Fax:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">&nbsp;</p>
      </td>
    </tr>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">23 Northampton Square,</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Mobile:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">+44(7980)639379</p>
      </td>
    </tr>
    <tr style="">
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">United Kingdom, EC1V 0HL</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal">Email:</p>
      </td>
      <td style="padding: 1.5pt;" valign="top">
      <p class="MsoNormal"><a name="howardcohtech.com"></a><a class="moz-txt-link-abbreviated" href="mailto:howard@cohtech.com">howard@cohtech.com</a></p>
      </td>
    </tr>
  </tbody>
</table>
<p class="MsoNormal">&nbsp;</p>
</div>
</div>
</body>
</html>

--------------000104050509050308090601--


--===============5966101029936249562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5966101029936249562==--

