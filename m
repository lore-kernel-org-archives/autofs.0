From: "Steve Potter" <geopagan@gmail.com>
Subject: Using auto.net on SuSE 10.1
Date: Tue, 3 Oct 2006 14:27:56 -0700
Message-ID: <31806a030610031427x7de0906ave47db71ce845d329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1353139225548263828=="
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

--===============1353139225548263828==
Content-Type: multipart/alternative; 
	boundary="----=_Part_114507_637121.1159910876876"

------=_Part_114507_637121.1159910876876
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm probably doing something wrong, but don't know enough about
how autofs works to know what to try.  My apoIogies if this has already
been discussed.  I tried searching the archives, but couldn't find
anything obviously related.

On machine 'foo', I export the directory '/export'.

On a SuSE 9.x machine running autofs 4.0pre10-364, when I do
an ls of /net/foo, I see 'export' (mounted from foo:/export) -
which is what I expect.

On a SuSE 10.1 machine I'm setting up, running autofs 4.1.4-23,
when I do an ls of /net/foo, instead of getting 'export', I get
the subdirectories of foo:/export.  That is, to get to the
file foo:/export/xyz I would need to use /net/foo/xyz instead
of /net/foo/export/xyz.

Is there some config setting that I need to do to get it
to act like it used to?

Thanks,
  Steve Potter

------=_Part_114507_637121.1159910876876
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm probably doing something wrong, but don't know enough about<br>how autofs works to know what to try.&nbsp; My apoIogies if this has already<br>been discussed.&nbsp; I tried searching the archives, but couldn't find<br>anything obviously related.
<br><br>On machine 'foo', I export the directory '/export'.<br><br>On a SuSE 9.x machine running autofs 4.0pre10-364, when I do<br>an ls of /net/foo, I see 'export' (mounted from foo:/export) -<br>which is what I expect.<br>
<br>On a SuSE 10.1 machine I'm setting up, running autofs 4.1.4-23,<br>when I do an ls of /net/foo, instead of getting 'export', I get<br>the subdirectories of foo:/export.&nbsp; That is, to get to the<br>file foo:/export/xyz I would need to use /net/foo/xyz instead
<br>of /net/foo/export/xyz.<br><br>Is there some config setting that I need to do to get it<br>to act like it used to?<br><br>Thanks,<br>&nbsp; Steve Potter<br><br>

------=_Part_114507_637121.1159910876876--


--===============1353139225548263828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1353139225548263828==--

