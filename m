From: Michael Coffman <michael.coffman@avagotech.com>
Subject: adding new file systems to host map
Date: Thu, 24 Feb 2011 07:27:07 -0700
Message-ID: <AANLkTikM2UyUa7xANa5LKnWe3S7LGCb+CU_nbNs5R-E1@mail.gmail.com>
Reply-To: michael.coffman@avagotech.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6371782834631960451=="
Return-path: <autofs-bounces@linux.kernel.org>
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

--===============6371782834631960451==
Content-Type: multipart/alternative; boundary=20cf3054a5cf2008f8049d08021a

--20cf3054a5cf2008f8049d08021a
Content-Type: text/plain; charset=ISO-8859-1

Hi,

If I am using host mapping on an autofs client and have a file system from a
server mounted, how do I get new file systems that are added to the file
server to be seen by the client?    Since I have one of the file systems
already busy on the client, the filer is never fully unmounted.  It seems
there should be a way to get it to refresh its map of what the server has
available.   I have tried stopping and restarting autofs, but this doesn't
help.    If there is a simple answer to this out there, I can't seem to find
it.

Anything?

Thanks.
-- 
-MichaelC

--20cf3054a5cf2008f8049d08021a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>If I am using host mapping on an autofs client and have a file s=
ystem from a server mounted, how do I get new file systems that are added t=
o the file server to be seen by the client?=A0=A0=A0 Since I have one of th=
e file systems already busy on the client, the filer is never fully unmount=
ed.=A0 It seems there should be a way to get it to refresh its map of what =
the server has available.=A0=A0 I have tried stopping and restarting autofs=
, but this doesn&#39;t help.=A0=A0=A0 If there is a simple answer to this o=
ut there, I can&#39;t seem to find it.=A0=A0=A0 <br>

<br>Anything?<br><br>Thanks.<br>-- <br>-MichaelC<br>

--20cf3054a5cf2008f8049d08021a--


--===============6371782834631960451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6371782834631960451==--

