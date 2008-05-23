From: Brent Callaghan <brentc@apple.com>
Subject: Re: Kernel Patch to support nested bind mounts
Date: Fri, 23 May 2008 11:27:44 -0700
Message-ID: <BFF938CE-B3EA-4245-9FB7-9DF485FE2D8A@apple.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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


Lukas Kolbe provided an example of a map entry in his nested bind mounts
patch request:

> eclipse-3.2 \
>  /bin          -rw,nosuid          fileserver:/export/stud/vol/ 
> eclipse-3.2/bin/linx86 \
>  /include      -rw,nosuid          fileserver:/export/stud/vol/ 
> eclipse-3.2/include \
>  /lib          -rw,nosuid          fileserver:/export/stud/vol/ 
> eclipse-3.2/lib/linx86 \
>  /man          -rw,nosuid          fileserver:/export/stud/vol/ 
> eclipse-3.2/man \
>  /share        -rw,nosuid          fileserver:/export/stud/vol/ 
> eclipse-3.2/share

The repetition of mount options in every entry isn't really needed.

Firstly, NFS mounts in most implementations already default to "rw", so
the "nosuid" option is really the only required one.


Also, at least in OpenSolaris based automounters, default options for
the entire map entry can be set after the map key and before the first
location entry.  So the example above could be written:

> eclipse-3.2   -nosuid  \
>  /bin                 fileserver:/export/stud/vol/eclipse-3.2/bin/ 
> linx86 \
>  /include         fileserver:/export/stud/vol/eclipse-3.2/include \
>  /lib                  fileserver:/export/stud/vol/eclipse-3.2/lib/ 
> linx86 \
>  /man              fileserver:/export/stud/vol/eclipse-3.2/man \
>  /share            fileserver:/export/stud/vol/eclipse-3.2/share


and if you want to set default options for all the entries in a map,
you can specify them in the auto_master map, e.g.

    /vol    auto_vol    -nosuid

If the map has a large number of entries, it makes their
admin a lot easier.

	Brent
