From: ramana <ramana@intraperson.com>
Subject: Re: exporting autofs managed directory using NFS
Date: Fri, 25 Jun 2004 06:45:54 +0530
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40DB7CCA.3020702@intraperson.com>
References: <40DADD60.5090201@intraperson.com>
	<16603.10543.236802.870131@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16603.10543.236802.870131@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, hpa@zytor.com

Jeff Moyer wrote:

>==> Regarding [autofs] exporting autofs managed directory using NFS; ramana <ramana@intraperson.com> adds:
>
>ramana> We are facing problems where /home is managed by autofs ( in
>ramana> Autodir ) but this directory is to to be exported using NFS.
>
>ramana> Exactly reverse of what autofs supposed to do -- lol
>
>ramana> When tried to mount nfs exported home some where else, Persmission
>ramana> denied error is reported by nfs server.
>
>Are you saying you want to reexport an nfs mounted filesystem?  I don't
>believe that is supported.
>
>-Jeff
>
>.
>
>  
>


No. Autodir do mount local directories only on autofs mounted fs.

In simple terms, exporting this special case autofs mounted dir using nfs.

Please check http://www.intraperson.com/autodir.html

-- 
http://www.intraperson.com
