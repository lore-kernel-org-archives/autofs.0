From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: AutoFS expire/timeout semantics
Date: Tue, 26 May 2009 11:20:31 -0300
Message-ID: <c2d0b6ec0905260720iafa7913w16203ae68b2f121d@mail.gmail.com>
References: <c2d0b6ec0905250608w159e5630xf77c470d192c09e4@mail.gmail.com>
	<4A1BF1DF.6020000@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A1BF1DF.6020000@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> It's not operations that cause the counter to be updated.
> It isn't possible to update the counter based on specific operations.
> It isn't possible to update the counter for all mount types based upon
> access only, such as listing a directory.
>
> The counter is updated during each expire check and is updated if the
> file system covering (for direct or offset mounts), or within (indirect
> mounts) the autofs file system has an elevated reference count. So, if
> there are open files or process working directories, or a path lookup is
> in progress at the time of the check, that is sufficient for the mount
> to be considered busy and the counter updated.

Thanks for the detailed explanation, Ian, this really helps.

Leonardo
