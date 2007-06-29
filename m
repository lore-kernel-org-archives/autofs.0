From: "William Prochazka" <billprozac@gmail.com>
Subject: autofs program user variable
Date: Thu, 28 Jun 2007 23:31:37 -0400
Message-ID: <812495870706282031p666550d2j15fd361e5899de9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2047322111341711595=="
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

--===============2047322111341711595==
Content-Type: multipart/alternative; 
	boundary="----=_Part_50182_13195051.1183087897788"

------=_Part_50182_13195051.1183087897788
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I am sort of new to autofs, but love it as it is truly great.
We currently do all of our automounts through LDAP (works great), but I
would love to do some programmatic mounts (improvements to the
auto.smbscript that is distributed with FC6).  I have made a number of
improvements,
but I would really like to know if there is a way of determining the user
that is attempting to traverse into the then automounted directory.  I have
some methods of guessing the info, but they are just guesses.  Since the
script is run by the service, $USER is worthless.  Any help would be much
appreciated.  Thanks and great work!

------=_Part_50182_13195051.1183087897788
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I am sort of new to autofs, but love it as it is truly great.<br>We currently do all of our automounts through LDAP (works great), but I would love to do some programmatic mounts (improvements to the auto.smb script that is distributed with FC6).&nbsp; I have made a number of improvements, but I would really like to know if there is a way of determining the user that is attempting to traverse into the then automounted directory.&nbsp; I have some methods of guessing the info, but they are just guesses.&nbsp; Since the script is run by the service, $USER is worthless.&nbsp; Any help would be much appreciated.&nbsp; Thanks and great work!
<br>

------=_Part_50182_13195051.1183087897788--


--===============2047322111341711595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2047322111341711595==--

