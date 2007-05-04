From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: sasl plugin compilation failure
Date: Fri, 4 May 2007 14:09:22 -0700
Message-ID: <20070504210921.GD16190@cornholio.qualcomm.com>
References: <44EC6AC2.3050503@inria.fr>
	<x49bqh1inrp.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49bqh1inrp.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Thu, May 03, 2007 at 05:46:18PM -0400, Jeff Moyer wrote:

> Guillaume> I had to disable sasl explicitely. I'm using gcc 4.1.1.  --
> Guillaume> Guillaume Rousse Projet Estime, INRIA Domaine de Voluceau
> Guillaume> Rocquencourt - B.P. 105 78153 Le Chesnay Cedex - France
> 
> Do you have krb5 development libraries installed?

I know I do... SLED10 install.. all the krb5* rpms are installed (64 and
32bit including -devel*) and all the openssl ones too.  

I was able to disable sasl for now too, which is ok for the short term
because we'd like to use sasl eventually.


-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
There was once a young man who, in his youth, professed his desire
become a great writer. When asked to define "great" he said, "I want to 
write stuff that the whole world will read, stuff that people will react 
to on a truly emotional level, stuff that will make them scream, cry, howl
in pain and anger!" == He now works for Microsoft, writing error messages.
