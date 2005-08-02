From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Difference in behaviour between 4.1.3 and 4.1.4
Date: Tue, 2 Aug 2005 09:12:53 -0400
Message-ID: <17135.29013.324264.704045@segfault.boston.redhat.com>
References: <netoe8gn34v.fsf@kuku.melbourne.sgi.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <netoe8gn34v.fsf@kuku.melbourne.sgi.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Max Matveev <makc@sgi.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Difference in behaviour between 4.1.3 and 4.1.4; Max Matveev <makc@sgi.com> adds:

makc> It seems that 4.1.4 has fixed a problem which 4.1.3 suffers from: if
makc> a server does not export /, then autofs mount via auto.net would fail
makc> with the following in the syslog:

makc> Aug 2 18:11:46 laura automount[6968]: mount(nfs): mkdir_path
makc> /net/mazur/var failed: Operation not permitted

makc> This is with SLES9 and autofs4-4.1.3. FC4 with autofs-4.1.4-5 works.
makc> Whould anybody know which particular change in 4.1.4 is responsible
makc> for fixing that problem? And is it something which was changed from
makc> 4.1.3 to 4.1.4 or is it FC's good work?

I have never seen this issue.  I haven't seen it in the upstream autofs
package nor in any variant of the Red Hat packages with which I work.

-Jeff
