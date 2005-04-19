From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Subject: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Tue, 19 Apr 2005 08:41:37 -0300
Message-ID: <20050419114136.GA13239@vision.ime.usp.br>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Mon, 18 Apr 2005, Michael Marion wrote:
> 
> I'll be doing some testing here tomorrow as well, since this sounds
> like it
> may solve the problem we've been having with lsf jobs submitted to
> linux hosts
> for a long time now... and has been a big thorn in our side.  The fact
> that
> it's a timing issue and it seems to happen more often when the filer
> in
> question is heavily loaded would seem to reinforce that this might be
> the
> cause as well.

Just to send my feedback: my testing with the patch shows no mount failures.
The logs show that sometimes the 0.1 second ping fails, but then it falls
back to 10 second and succeeds.

Please CC any replies to me, because I'm not a subscriber.

Daniel
