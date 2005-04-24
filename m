From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Subject: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Sun, 24 Apr 2005 13:18:05 -0300
Message-ID: <20050424161805.GA15363@vision.ime.usp.br>
References: <20050417154240.GA17232@uio.no>
	<20050417181827.GA13101@vision.ime.usp.br>
	<Pine.LNX.4.62.0504182142090.14946@donald.themaw.net>
	<42640E89.7090005@redhat.com>
	<Pine.LNX.4.62.0504241602310.18935@donald.themaw.net>
	<Pine.LNX.4.62.0504241728230.20970@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504241728230.20970@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>, Chris Feist <cfeist@redhat.com>

Hi,

On Sun, Apr 24, 2005 at 05:32:52PM +0800, raven@themaw.net wrote:
> 
> Ooops. Spotted something else.
> 
> The function is_multimount_entry should use a || as multi-mount entries 
> can be like:

I would also suggest a change in the name of this function to something
like is_replicated_entry. Multi-mounts and replicated mounts are
different things, and in this case it could confuse the reader.

Thanks,

Daniel
